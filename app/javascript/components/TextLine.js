import React, { useState, useEffect, useContext } from "react";
import { TextLineContext, RecogitoContext } from './services/AnnotationContext';
import { GetTexline } from "./services/AnnotationAPI";

const TextLine = () => {
  const textLineId = useContext(TextLineContext);
  const [text, setText] = useState("");

  useEffect(() => {
    GetTexline(textLineId).then((data) => {
      setText(data.content);
    });
  }, []);

  return (<>
    <div className="d-flex align-items-stretch align-items-start flex-column mt-4">
      <div id="text-line-content">
        { text }
      </div>
    </div>
  </>);
};

export default TextLine;
