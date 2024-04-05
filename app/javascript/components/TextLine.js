import React, { useEffect, useContext } from "react";
import PropTypes from "prop-types";
import { TextContentContext } from "./services/AnnotationContext";

const TextLine = ({forwardRef, initRecogito}) => {
  const textContent = useContext(TextContentContext);

  useEffect(() => {
    initRecogito();
  }, []);

  return (
    <div className="d-flex align-items-stretch align-items-start flex-column mt-4">
      <div id="text-line-content" ref={forwardRef}>
        { textContent }
      </div>
    </div>
  );
};

TextLine.propTypes = {
  forwardRef: PropTypes.object,
  initRecogito: PropTypes.func
};

export default TextLine;
