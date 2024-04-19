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
    <aside id="aside-main" className="aside-main d-flex align-items-stretch align-items-start flex-column aside-end fw-light aside-hide-xs">
      <div className="aside-main__header clearfix px-3 py-4 mb-1 text-center bg-diff align-self-baseline w-100">
        <h2 className="h2">
          Text Line ID<br/>
          <span className="h2__bigger" aria-level="2">{textLineId}</span>
        </h2>
      </div>
      <div className="aside-main__wrapper scrollable-vertical scrollable-styled-light align-self-baseline h-100 w-100">
        <nav className="nav-deep nav-deep-light nav-deep-hover">
          <ul className="annotations-list nav flex-column">
            {annotations.map((a) => (
              <li className="annotations-list__item nav-item" key={a.id} data-id={a.id}>
                <a className="nav-link d-inline-block r6o-widget r6o-tag" href="#" onClick={() => props.onSelected(a)}>
                  { a.body.filter(body => body.purpose === 'commenting').map((b) => (
                    <p key={a.id + b.purpose}>{b.value}</p>
                  ))}
                  <ul className="r6o-taglist">
                    { a.body.filter(body => body.purpose === 'tagging').map((b) => (
                      <li key={b.value}><span className="r6o-label">{b.value}</span></li>
                    ))}
                  </ul>
                </a>
                <button className="fi fi-pencil d-inline-block" onClick={() => props.onSelected(a)} />
                <button className="fi fi-thrash d-inline-block" onClick={() => deleteAnnotation(a)} />
              </li>
            ))}
          </ul>
        </nav>
      </div>
    </aside>
  );
}

export default Sidebar;
