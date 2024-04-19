import { createContext } from 'react';

const expression = /^\/annotators\/tasks\/(\d+)\/text_lines\/(\d+)/i

export const RecogitoContext = createContext(null);

let match = expression.exec(window.location.pathname);

export const TaskContext = createContext(match ? match[1] : null);
export const TextLineContext = createContext(match ? match[2] : null);
export const TextContentContext = createContext(null);

export const ApiUrl = `/api/v1/tasks/${TaskContext._currentValue}/text_lines/${TextLineContext._currentValue}/annotations/`;
