# frozen_string_literal: true

module Management
  module CrudActions
    extend ActiveSupport::Concern

    def index
      @search = search_form_klass.new(search_params)
      @resources = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @resource = klass.find(params[:id])
    end

    def new
      @resource = klass.new
    end

    def create
      @resource = klass.new
      @resource.assign_attributes(post_params)
      if @resource.save
        flash.now[:notice] = t("infold.flash.created")
        render :form
      else
        flash.now[:alert] = t("infold.flash.invalid")
        render :form, status: :unprocessable_entity
      end
    end

    def edit
      @resource = klass.find(params[:id])
    end

    def update
      @resource = klass.find(params[:id])
      @resource.assign_attributes(post_params)
      if @resource.save
        flash.now[:notice] = t("infold.flash.updated")
        render :form
      else
        flash.now[:alert] = t("infold.flash.invalid")
        render :form, status: :unprocessable_entity
      end
    end

    def destroy
      @resource = klass.find(params[:id])
      if @resource.destroy
        redirect_to [:management, klass.name.underscore.pluralize], status: :see_other, flash: { notice: t("infold.flash.destroyed") }
      else
        flash.now[:alert] = t("flash.invalid_destroy")
        render :show, status: :unprocessable_entity
      end
    end
  end
end
