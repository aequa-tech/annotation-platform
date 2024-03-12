// Entry point for the build script in your package.json

import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './components/App';

const element = document.getElementById('root');
const textEl = document.getElementById('text-line-content');
const root = createRoot(element);
const attributes = Array.from(textEl.attributes).reduce((attrs, attr) => {
  attrs[attr.name] = attr.value;
  return attrs;
}, {});

root.render(<App {...attributes} />);
