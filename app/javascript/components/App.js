import { useContext, useState, useRef, useMemo } from "react";
import { Recogito } from "@recogito/recogito-js/src/index";
import { CreateAnnotation, DeleteAnnotation, UpdateAnnotation } from "./services/AnnotationAPI";
import { RecogitoContext, TextLineContext, TextContentContext, ApiUrl } from "./services/AnnotationContext";
import SimpleTextWidget from "./widgets/SimpleTextWidget";
import CustomTagWidget from "./widgets/CustomTagWidget";
import Sidebar from "./Sidebar";
import TextLine from "./TextLine";
import PropTypes from "prop-types";


function App({ textContent }) {
  const textLineId = useContext(TextLineContext);
  const [annotations, setAnnotations] = useState([]);

  const annotoriousRef = useRef(null);
  const textEl = useRef(null);

  const deleteAnnotationFromList = (annotation) => {
    annotoriousRef.current.removeAnnotation(annotation);
    annotoriousRef.current.handleAnnotationDeleted(annotation);
  };
  const recogitoValue = useMemo(() => (
    {annotations, deleteAnnotationFromList}), [annotations, deleteAnnotationFromList]
  );

  const selectedAnnotationEvent = (annotation) => {
    annotoriousRef.current.selectAnnotation(annotation.id);
  }

  const initRecogito = () => {
    const config = {
      widgets: [
        { widget: SimpleTextWidget },
        { widget: CustomTagWidget }
      ],
      readOnly: false,
      content: textEl.current,
    };

    annotoriousRef.current = new Recogito(config);

    annotoriousRef.current.loadAnnotations(ApiUrl).then((list) => {
      setAnnotations(list);
    });

    annotoriousRef.current.on("createAnnotation", (annotation) => {
      CreateAnnotation(annotation);
      setAnnotations(annotoriousRef.current.getAnnotations());
    });

    annotoriousRef.current.on("updateAnnotation", (annotation) => {
      UpdateAnnotation(annotation);
      setAnnotations(annotoriousRef.current.getAnnotations());
    });

    annotoriousRef.current.on("deleteAnnotation", (annotation) => {
      DeleteAnnotation(annotation);
      setAnnotations(annotoriousRef.current.getAnnotations());
    });

    annotoriousRef.current.setAuthInfo({
      // used every time the user creates/updates an annotation
      id: "user-id",
      displayName: "User Name"
    });
  }

  return(
    <TextContentContext.Provider value={textContent}>
      <TextLineContext.Provider value={textLineId}>
        <RecogitoContext.Provider value={recogitoValue}>
          <TextLine forwardRef={textEl} initRecogito={initRecogito} text={textContent} />
          <Sidebar onSelected={selectedAnnotationEvent}/>
        </RecogitoContext.Provider>
      </TextLineContext.Provider>
    </TextContentContext.Provider>
  );
}

App.propTypes = {
  textContent: PropTypes.string
};

export default App;
