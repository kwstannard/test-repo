import React from "react";
import ReactDOM from "react-dom/client";
import { HTML5Backend } from "react-dnd-html5-backend"
import { DndProvider, useDrag, useDrop } from "react-dnd"

const App = () => {
  const [todos, setTodos] = React.useState([]);
  const [doings, setDoings] = React.useState([]);
  const [dones, setDones] = React.useState([]);

  const addToToDo = addItemFunc(setTodos);
  const addToDoing = addItemFunc(setDoings);
  const addToDone = addItemFunc(setDones);

  const cutFromToDo = cutItemFunc(setTodos);
  const cutFromDoing = cutItemFunc(setDoings);
  const cutFromDone = cutItemFunc(setDones);

  return (
    <DndProvider backend={HTML5Backend}>
      <List name="ToDo" items={todos} addItem={addToToDo} cutItem={cutFromToDo} />
      <List name="Doing" items={doings} addItem={addToDoing} cutItem={cutFromDoing} />
      <List name="Done" items={dones} addItem={addToDone} cutItem={cutFromDone} />

      <NewItemForm addItem={addToToDo}/>
    </DndProvider>
  )
};

const addItemFunc = (setList) => {
  return (item) => {
    setList((prevList) => [
      ...prevList,
      item
    ]);
  }
};

const cutItemFunc = (setList) => {
  return (item) => {
    setList((prevList) => prevList.filter((i) => (console.log(i, item) && i !== item )));
  }
};

const List = ({name, items, addItem, cutItem}) => {
  const [{isOver, canDrop }, drop] = useDrop(() => ({
    accept: "Item",
    drop: addItem
  }));

  return(
    <div id={name} ref={drop}>
      <h1>{name}</h1>
      <ul>
        { items.map((item) => <Item item={item} liftFunc={cutItem} /> )}
      </ul>
    </div>
  );
}

const Item = ({item, liftFunc}) => {
  const [{ isDragging }, drag] = useDrag(() => ({
    type: "Item",
    item: item,
    end: liftFunc
  }));
  return(<li key={item.key} ref={drag}>{item.text}</li>)
};

const NewItemForm = ({addItem}) => {
  const newItem = (event) => {
    event.preventDefault();
    addItem({text: event.target.itemText.value, key: event.target.itemText.value});
    event.target.reset();
  };
  return(
    <form id="#newItemForm" onSubmit={newItem}>
      <label htmlFor="itemText">Text</label>
      <input type="text" name="itemText" id="itemText" placeholder="Clean" />
      <button><span>Submit</span></button>
    </form>
  )
};

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);

root.render(<App />);
