import React, { useContext } from 'react';
import { TextLineContext, RecogitoContext } from './services/AnnotationContext';
import WebAnnotation from "@recogito/recogito-client-core/src/WebAnnotation";

const Sidebar = (props) => {
  const textLineId = useContext(TextLineContext);
  const { annotations, deleteAnnotationFromList } = useContext(RecogitoContext);

  const deleteAnnotation = (annotation) => {
    annotation = new WebAnnotation(annotation);
    deleteAnnotationFromList(annotation);
  }

  return (
    <aside id="aside-main" className="d-flex align-items-stretch align-items-start flex-column aside-end aside-secondary fw-light aside-hide-xs">
      <div className="clearfix px-3 py-4 mb-1 text-center bg-diff align-self-baseline w-100">
        <h5 className="h5">Sidebar</h5>
        <p>Text Line ID: {textLineId}</p>
      </div>
      <div className="aside-wrapper scrollable-vertical scrollable-styled-light align-self-baseline h-100 w-100">
        <nav className="nav-deep nav-deep-light nav-deep-hover">
          <ul className="nav flex-column">
            {annotations.map((a) => (
              <li key={a.id} className="nav-item" data-id={a.id}>
                <a className="nav-link d-inline-block" href="#" onClick={() => props.onSelected(a)}>{ a.body[0].value }</a>
                <button className="fi fi-thrash d-inline-block" onClick={() => deleteAnnotation(a)}></button>
              </li>
            ))}
          </ul>
        </nav>
      </div>
    </aside>
  );
}

export default Sidebar;
