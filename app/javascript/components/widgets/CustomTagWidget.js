import { useEffect, useState, useRef } from 'react';
import { GetTaxonomies } from '../services/AnnotationAPI';
import { CSSTransition } from 'react-transition-group';
import { CloseIcon } from '@recogito/recogito-client-core/src/Icons';

function CustomTagWidget(props) {
  const [tags, setTags] = useState([]);
  const elem = useRef();

  const selectedTags = props.annotation?.bodies.filter(body => body.purpose === 'tagging').map(body => body.value) || [];

  useEffect(() => {
    GetTaxonomies()
      .then(response => {
        setTags(response);
      })
      .catch(error => {
        console.error('Error fetching tags:', error);
      });
  }, []);

  const handleSelectChange = (event) => {
    const selected = Array.from(event.target.selectedOptions, option => option.value);

    selected.forEach((tag) => {
      if(selectedTags.includes(tag)){
        onDelete(tag)
      } else {
        props.onAppendBody({
          type: "TextualBody",
          purpose: "tagging",
          value: tag
        });
      }
    });
  };

  /* FROM TAG WIDGET */
  const [ showDelete, setShowDelete ] = useState(false);

  const toggle = tag => _ => {
    if (showDelete === tag) // Removes delete button
      setShowDelete(false);
    else
      setShowDelete(tag); // Sets delete button on a different tag
  };

  const onDelete = tag => evt => {
    const toRemove = props.annotation.body.find(body => body.purpose === 'tagging', body => body.value === tag);
    evt.stopPropagation();
    props.onRemoveBody(toRemove);
  }

  /* END FROM TAG WIDGET */

  return (
    <div className="r6o-widget r6o-tag">
      { selectedTags.length > 0 &&
        <ul className="r6o-taglist">
          { selectedTags.map(tag =>
            <li key={tag} onClick={toggle(tag)}>
              <span className="r6o-label">{tag}</span>
              <CSSTransition in={showDelete === tag} timeout={200} classNames="r6o-delete">
                <span className="r6o-delete-wrapper" onClick={onDelete(tag)}>
                  <span className="r6o-delete">
                    <CloseIcon width={12} />
                  </span>
                </span>
              </CSSTransition>
            </li>
          )}
        </ul>
      }
      <select multiple value={selectedTags} onChange={handleSelectChange}>
        {tags.map(tag => (
          <option key={tag.id} value={tag.title}>{tag.title}</option>
        ))}
      </select>
  </div>
  );
}

export default CustomTagWidget;
