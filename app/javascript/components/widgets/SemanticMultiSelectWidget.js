import PropTypes from "prop-types";
import useClickOutside from '@recogito/recogito-client-core/src/editor/useClickOutside';
import { useEffect } from "react";

SemanticMultiSelectWidget.propTypes = {
  annotation: PropTypes.object,
  onAppendBody: PropTypes.func,
  onUpdateBody: PropTypes.func
};

function SemanticMultiSelectWidget(props) {
  const elem = React.useRef();
  const [ isDropdownOpen, setIsDropdownOpen ] = React.useState(false);
  const [ query, setQuery ] = React.useState(props.query);

  useEffect(() => {
    if (props.query) {
      setQuery(props.query);
    }
  }, [props.query]);


  const onToggleDropdown = function() {
    setIsDropdownOpen(!isDropdownOpen);
  }

  // useClickOutside(elem, () => setIsDropdownOpen(false));


  return (
    <div className="r6o-widget r6o-semtags" ref={elem} >
      <div
        className={ isDropdownOpen ? 'r6o-semtags-taglist dropdown-open' : 'r6o-semtags-taglist' }
        onClick={onToggleDropdown}>

        <div className="placeholder">
          <label>Click to add semantic tag...</label>
        </div>
      </div>
    </div>
  )
}

export default SemanticMultiSelectWidget;
