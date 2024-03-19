function TaxonomySelectorWidget(args) {
  // 1. Find a current color setting in the annotation, if any
  const currentColorBody = args.annotation
    ? args.annotation.bodies.find(function (b) {
        return b.purpose === "highlighting";
      })
    : null;

  // 2. Keep the value in a variable
  const currentColorValue = currentColorBody ? currentColorBody.value : null;

  // 3. Triggers callbacks on user action
  const addTag = function (evt) {
    evt.target.classList.toggle("selected");

    if (currentColorBody) {
      if (evt.target.dataset.tag === currentColorValue) {
        // If the user clicks on the currently active color, remove it
        args.onRemoveBody(currentColorBody);
      } else {
        args.onUpdateBody(currentColorBody, {
          type: "TextualBody",
          purpose: "highlighting",
          value: evt.target.dataset.tag
        });
      }
    } else {
      args.onAppendBody({
        type: "TextualBody",
        purpose: "highlighting",
        value: evt.target.dataset.tag
      });
    }
  };

  // 4. This part renders the UI elements
  const createButton = function (value) {
    const button = document.createElement("button");

    if (value === currentColorValue) button.className = "selected";

    const newContent = document.createTextNode(value);
    button.dataset.tag = value;
    button.classList.add('r6o-btn')
    button.appendChild(newContent);
    button.addEventListener("click", addTag);
    return button;
  };

  const container = document.createElement("div");
  container.className = "colorselector-widget";

  const button1 = createButton("Tax1");
  const button2 = createButton("Tax2");
  const button3 = createButton("Tax3");

  container.appendChild(button1);
  container.appendChild(button2);
  container.appendChild(button3);

  return container;
};

export default TaxonomySelectorWidget;
