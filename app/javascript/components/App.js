import { useEffect, useState } from "react";
import { Recogito } from "@recogito/recogito-js";
import { CreateAnnotation, DeleteAnnotation, UpdateAnnotation } from "./services/AnnotationAPI";
import { AnnotationsContext, TextLineContext, ApiUrl, QueryParams } from "./services/AnnotationContext";
import TaxonomySelectorWidget from "./widgets/TaxonomySelectorWidget";

function App(props) {
  let annotorious = null;
  const [annotations, setAnnotations] = useState({});

  useEffect(() => {
    const config = {
      widgets: [
        { widget: "COMMENT" },
        { widget: TaxonomySelectorWidget },
      ],
      readOnly: false,
      content: props.id,
    };
    annotorious = new Recogito(config);

    annotorious.loadAnnotations(ApiUrl + QueryParams).then((list) => {
      console.log("loaded annotations", list);
      setAnnotations(list); // TODO: not working
    });

    annotorious.on("createAnnotation", (annotation) => {
      CreateAnnotation(annotation);
    });

    annotorious.on("updateAnnotation", (annotation) => {
      UpdateAnnotation(annotation);
    });

    annotorious.on("deleteAnnotation", (annotation) => {
      DeleteAnnotation(annotation);
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
