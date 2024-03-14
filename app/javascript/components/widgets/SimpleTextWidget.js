import PropTypes from "prop-types";

SimpleTextWidget.propTypes = {
  annotation: PropTypes.object,
  onAppendBody: PropTypes.func.isRequired,
  onUpdateBody: PropTypes.func.isRequired
};

function SimpleTextWidget(props) {
  // 1. Find a current comment in the annotation, if any
  const currentCommentBody = props.annotation
    ? props.annotation.bodies.find(function (b) {
        return b.purpose === "commenting";
      })
    : null;

  const onUpdateComment = function(e) {
    if (currentCommentBody) {
      props.onUpdateBody(currentCommentBody, { ...currentCommentBody, value: e.target.value, purpose: "commenting" });
    } else {
      props.onAppendBody({ type: "TextualBody", value: e.target.value, purpose: "commenting" });
    }
  }

  return(
    <div className="r6o-widget comment editable">
      <textarea
        className="r6o-editable-text"
        defaultValue={props.annotation?.body[0]?.value || ""}
        rows="5"
        placeholder="Add a comment..."
        disabled={ false }
        onChange={ onUpdateComment } />
    </div>
  );
};

export default SimpleTextWidget;
