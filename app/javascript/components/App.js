import { useEffect, useState } from "react";
import { Recogito } from "@recogito/recogito-js";
import { CreateAnnotation } from "./services/AnnotationAPI";
import { AnnotationsContext, TextLineContext, ApiUrl } from "./services/AnnotationContext";
import TaxonomySelectorWidget from "./widgets/TaxonomySelectorWidget";

function App(props) {
  let annotorious = null;
  const [annotations, setAnnotations] = useState({});
  const config = {
    widgets: [
      { widget: "COMMENT" },
      { widget: TaxonomySelectorWidget },
    ],
    readOnly: false,
    content: props.id,
  };

  annotorious = new Recogito(config);

  useEffect(() => {
    annotorious.loadAnnotations(ApiUrl).then((list) => {
      console.log("loaded annotations", list);
      setAnnotations(list);
    });

    annotorious.on("createAnnotation", (annotation) => {
      // post a CREATE to the server
      console.log("current annotation", annotation);
      CreateAnnotation(annotation);
    });

    annotorious.on("updateAnnotation", (annotation) => {
      // put an UPDATE to the server
      console.log("current annotation", annotation);
    });

    annotorious.on("deleteAnnotation", (annotation) => {
      // DELETE an annotation from the server
      console.log("current annotation", annotation);
    });

    annotorious.setAuthInfo({
      // used every time the user creates/updates an annotation
      id: "user-id",
      displayName: "User Name"
    });

  }, []);

  return(null);
  return(
    <TextLineContext.Provider>
      <AnnotationsContext.Provider value={{annotations, setAnnotations}}>
      </AnnotationsContext.Provider>
    </TextLineContext.Provider>
  );
}

export default App;
