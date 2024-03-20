import React, { useContext } from 'react';
import { TextLineContext, RecogitoContext } from './services/AnnotationContext';
import WebAnnotation from "@recogito/recogito-client-core/src/WebAnnotation";

const Sidebar = () => {
  const textLineId = useContext(TextLineContext);
  const { annotations, deleteAnnotationFromList } = useContext(RecogitoContext);

  const deleteAnnotation = (annotation) => {
    annotation = new WebAnnotation(annotation);
    deleteAnnotationFromList(annotation);
  }

  return (
    <div>
      <h1>Sidebar</h1>
      <p>Text Line ID: {textLineId}</p>
      <ul>
        {annotations.map((a) => (
          <li key={a.id}>
            {a.body[0].value}
            <button onClick={() => deleteAnnotation(a)}>Elimina</button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default Sidebar;
