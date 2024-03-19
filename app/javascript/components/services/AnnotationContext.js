import { createContext } from 'react';

const expression = /^\/text_lines\/(\d+)/i
const findId = (url) => {
    const match = expression.exec(url);
    if (match) {
        return match[1];
    }
    return null;
};

export const AnnotationsContext = createContext(null);
export const TextLineContext = createContext(findId(window.location.pathname || ''));
export const ApiUrl = `../api/v1/annotations/`;
export const QueryParams = `?text_line_id=${findId(window.location.pathname) || ''}`;
