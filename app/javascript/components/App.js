import { useContext, useEffect, useState, useRef } from "react";
import { Recogito } from "@recogito/recogito-js/src/index";
import { CreateAnnotation, DeleteAnnotation, UpdateAnnotation } from "./services/AnnotationAPI";
import { RecogitoContext, TextLineContext, ApiUrl } from "./services/AnnotationContext";
import SimpleTextWidget from "./widgets/SimpleTextWidget";
import CustomTagWidget from "./widgets/CustomTagWidget";
import Sidebar from "./Sidebar";
import TextLine from "./TextLine";


function App() {
  const textLineId = useContext(TextLineContext);
  const [annotations, setAnnotations] = useState([]);
  const [textLineLoaded, setTextLineLoaded] = useState(false);
  const annotoriousRef = useRef(null);

  const deleteAnnotationFromList = (annotation) => {
    annotoriousRef.current.removeAnnotation(annotation);
    annotoriousRef.current.handleAnnotationDeleted(annotation);
  };

  const selectedAnnotationEvent = (annotation) => {
    annotoriousRef.current.selectAnnotation(annotation.id);
  }

  useEffect(() => {
    const config = {
      widgets: [
        { widget: SimpleTextWidget },
        { widget: CustomTagWidget }
      ],
      readOnly: false,
      content: "text-line-content",
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
  }, [textLineLoaded]);

  return(
    <TextLineContext.Provider value={textLineId}>
      <RecogitoContext.Provider value={{annotations, deleteAnnotationFromList}}>
        <TextLine onLoaded={() => setTextLineLoaded(true)} />
        <Sidebar onSelected={selectedAnnotationEvent}/>
      </RecogitoContext.Provider>
    </TextLineContext.Provider>
  );
}

export default App;
