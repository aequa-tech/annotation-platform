// Entry point for the build script in your package.json

import React from 'react'
import { createRoot } from 'react-dom/client';
import App from './components/App';

const root = createRoot(document.getElementById('dashboard'));
root.render(<App/>);
