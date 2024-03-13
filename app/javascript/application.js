// Entry point for the build script in your package.json

import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './components/App';

export default function mount(components) {
  document.addEventListener("DOMContentLoaded", () => {
    const mountPoints = document.querySelectorAll("[data-react-component]");
    mountPoints.forEach((mountPoint) => {
      const { dataset } = mountPoint;
      const componentName = dataset.reactComponent;
      if (componentName) {
        const Component = components[componentName];
        if (Component) {
          const props = JSON.parse(dataset.props);
          const root = createRoot(mountPoint);
          root.render(<Component {...props} />);
        } else {
          console.warn(
            "WARNING: No component found for: ",
            dataset.reactComponent,
            components
          );
        }
      }
    });
  });
}

mount({ App });
