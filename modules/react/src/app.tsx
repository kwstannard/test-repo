import React from "react";
import ReactDOM from "react-dom/client";

const App = () => {
  return(
    <table>
      <tr><th>ToDo</th><th>Doing</th><th>Done</th></tr>
    </table>
  )
};

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);

root.render(<App />);
