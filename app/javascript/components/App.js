import { useContext, useEffect, useState, useRef } from "react";
import { Recogito } from "@recogito/recogito-js/src/index";
import { CreateAnnotation, DeleteAnnotation, UpdateAnnotation } from "./services/AnnotationAPI";
import { RecogitoContext, TextLineContext, ApiUrl } from "./services/AnnotationContext";
import SimpleTextWidget from "./widgets/SimpleTextWidget";
import CustomTagWidget from "./widgets/CustomTagWidget";
import Sidebar from "./Sidebar";


function App(props) {
  const textLineId = useContext(TextLineContext);
  const [annotations, setAnnotations] = useState([]);
  const annotoriousRef = useRef(null);

  const deleteAnnotationFromList = (annotation) => {
    annotoriousRef.current.removeAnnotation(annotation);
    annotoriousRef.current.handleAnnotationDeleted(annotation);
  };

  useEffect(() => {
    const config = {
      widgets: [
        { widget: SimpleTextWidget },
        { widget: CustomTagWidget }
      ],
      readOnly: false,
      content: props.id,
    };
    annotoriousRef.current = new Recogito(config);;

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
  }, [props.id]);

  return(
    <TextLineContext.Provider value={textLineId}>
      <RecogitoContext.Provider value={{annotations, deleteAnnotationFromList}}>
        <Sidebar />
      </RecogitoContext.Provider>
    </TextLineContext.Provider>
  );
}

export default App;
