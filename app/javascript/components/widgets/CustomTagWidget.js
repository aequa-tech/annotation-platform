import { useEffect, useState, useRef } from 'react';
import { GetTaxonomies } from '../services/AnnotationAPI';
import { CSSTransition } from 'react-transition-group';
import { CloseIcon } from '@recogito/recogito-client-core/src/Icons';
import SuggestionsLoaded from './custom_tag_widget/SuggestionsLoaded';
import PropTypes from "prop-types";

import './CustomTagWidget.scss';

function CustomTagWidget(props) {
  const [tags, setTags] = useState([]);
  const elem = useRef();
  const [ isDropdownOpen, setIsDropdownOpen ] = useState(false);
  const [ loadState, setLoadState ] = useState('LOADED'); // LOADING, LOADED, FAILED

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

  const handleSelectChange = (tag) => {
    if(selectedTags.includes(tag.title)){
      onDelete(tag.value)
    } else {
      props.onAppendBody({
        type: "TaxonomyBody",
        purpose: "tagging",
        value: tag.title
      });
    }

    setIsDropdownOpen(false);
  };

  const onToggleDropdown = () =>
    setIsDropdownOpen(!isDropdownOpen);

  /* FROM TAG WIDGET */
  const [ showDelete, setShowDelete ] = useState(false);

  const toggle = tag => _ => {
    if (showDelete === tag) // Removes delete button
      setShowDelete(false);
    else
      setShowDelete(tag); // Sets delete button on a different tag
  };

  const onDelete = tag => evt => {
    const toRemove = props.annotation.body.filter(body => body.purpose === 'tagging').find(body => body.value === tag);
    evt.stopPropagation();
    props.onRemoveBody(toRemove);
  }

  /* END FROM TAG WIDGET */

  return (
    <div className="r6o-widget r6o-semtags taxonomy-widget">
      { selectedTags.length > 0 &&
        <div className="r6o-widget r6o-tag">
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
        </div>
      }
      <div
        className={ isDropdownOpen ? 'r6o-semtags-taglist dropdown-open' : 'r6o-semtags-taglist' }
        onClick={onToggleDropdown}>
        <div className="placeholder">
          <p className="d-inline-block">Click to add taxonomies...</p>
        </div>
      </div>

      {isDropdownOpen &&
        <div className="r6o-semtags-dropdown-container">
          <div className="r6o-semtags-dropdown">
            <div className="r6o-semtags-dropdown-top"></div>

            <div className="r6o-semtags-dropdown-bottom">
              {loadState === 'LOADED' &&
                <SuggestionsLoaded
                  suggestions={tags}
                  onSelectSuggestion={handleSelectChange} /> }
            </div>
          </div>
        </div>
      }
    </div>
  );
}

CustomTagWidget.propTypes = {
  annotation: PropTypes.object,
  onAppendBody: PropTypes.func,
  onRemoveBody: PropTypes.func
};

export default CustomTagWidget;
