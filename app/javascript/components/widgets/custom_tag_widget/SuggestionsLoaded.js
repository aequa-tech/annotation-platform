import React from 'react';
import PropTypes from "prop-types";

import './SuggestionsLoaded.scss';

const SuggestionsLoaded = props => {

  return (
    <ul>
      {props.suggestions.map(suggestion =>
        <li
          key={suggestion.id}
          onClick={() => props.onSelectSuggestion(suggestion)}>

          <p>{ suggestion.title }</p>
          <p className="description">{suggestion.description}</p>
        </li>
      )}
    </ul>
  )

}

SuggestionsLoaded.propTypes = {
  suggestions: PropTypes.array,
  onSelectSuggestion: PropTypes.func
};

export default SuggestionsLoaded;
