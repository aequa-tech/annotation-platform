import { createContext } from 'react';

const expression = /^\/annotators\/tasks\/(\d+)\/text_lines\/(\d+)/i

export const RecogitoContext = createContext(null);

export const TaskContext = createContext(expression.exec(window.location.pathname)[1]);
export const TextLineContext = createContext(expression.exec(window.location.pathname)[2]);
export const TextContentContext = createContext(null);

export const ApiUrl = `/api/v1/tasks/${TaskContext._currentValue}/text_lines/${TextLineContext._currentValue}/annotations/`;
