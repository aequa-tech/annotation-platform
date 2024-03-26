# frozen_string_literal: true

module Management
  module CrudActions
    extend ActiveSupport::Concern

    included do
      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    end

    def index
      @search = search_form_klass.new(search_params)
      scope = policy_scope(klass)
      @resources = @search.perform(scope, params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @resource = klass.find(params[:id])
      authorize @resource
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
      authorize @resource
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
      authorize @resource

      if @resource.destroy
        redirect_to [:management, klass.base_class.name.underscore.pluralize.to_sym], status: :see_other, flash: { notice: t("infold.flash.destroyed") }
      else
        flash.now[:alert] = t("flash.invalid_destroy")
        render :show, status: :unprocessable_entity
      end
    end

    private

    def user_not_authorized
      flash_message = t("pundit.not_authorized_error")

      respond_to do |format|
        format.html do
          if request.variant == [:turbo_frame]
            render(:forbidden, status: :forbidden, layout: "management", locals: { flash: flash_message })
          else
            redirect_to(request.referer || root_path, alert: flash_message)
          end
        end
      end
    end
  end
end
