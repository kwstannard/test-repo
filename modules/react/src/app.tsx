import React from "react";
import ReactDOM from "react-dom/client";
import { HTML5Backend } from "react-dnd-html5-backend"
import { DndProvider, useDrag, useDrop } from "react-dnd"

const App = () => {
  const orig_todos=[
    {text: 'Do the dishes', key: 'Do the dishes'},
    {text: 'Do the lawn', key: 'Do the lawn'},
    {text: 'Do the monster mash', key: 'Do the monster mash'},
    {text: 'Do the do', key: 'Do the do'},
  ]

  // const [todos, setTodos] = React.useState(orig_todos);
  const [todos, setTodos] = React.useState([]);
  const [doings, setDoings] = React.useState([]);
  const [dones, setDones] = React.useState([]);

  const cutItemAtToDo = cutItemAtFunc(setTodos);
  const cutItemAtDoing = cutItemAtFunc(setDoings);
  const cutItemAtDone = cutItemAtFunc(setDones);

  const addToToDo = addItemFunc(setTodos);
  const addToDoing = addItemFunc(setDoings);
  const addToDone = addItemFunc(setDones);

  const insertAtToDo = insertItemAtFunc(setTodos);
  const insertAtDoing = insertItemAtFunc(setDoings);
  const insertAtDone = insertItemAtFunc(setDones);

  return (
    <DndProvider backend={HTML5Backend}>
      <List name="ToDo" items={todos} addItem={addToToDo} cutItemAt={cutItemAtToDo} insertItemAt={insertAtToDo} />
      <List name="Doing" items={doings} addItem={addToDoing} cutItemAt={cutItemAtDoing} insertItemAt={insertAtDoing} />
      <List name="Done" items={dones} addItem={addToDone} cutItemAt={cutItemAtDone} insertItemAt={insertAtDone} />

      <NewItemForm addItem={addToToDo}/>
      <button onClick={pizzazz}>Celebrate!</button>
    </DndProvider>
  )
};

const pizzazzStyle = document.createElement("style")
document.head.appendChild(pizzazzStyle)

const pizzazz = () => {
  var deg = 0;
  iid=setInterval(
    () => {
      if (deg < (360 * 2)) { deg++ }
      pizzazzStyle.textContent = "#root { transform: rotate("+deg+"deg) }\n img { opacity: "+deg/8+"% }"
    },
    1
  )

  setTimeout(
    () => { clearInterval(iid); pizzazzStyle.textContent = "" },
    4000
  )
}

const addItemFunc = (setList) =>
  (item) => setList((prevList) => [...prevList,item]) && {result: true};

const insertItemAtFunc = (setList) =>
  (index) =>
    (item, monitor) =>
      setList((prevList) => [...prevList.slice(0,index), item, ...prevList.slice(index)])

const cutItemAtFunc = (setList) =>
  (index) =>
    (item, monitor) =>
      setList((prevList) => prevList.splice(index, 1) && prevList)

const List = ({name, items, addItem, cutItemAt, insertItemAt}) => {
  const [{isOver, canDrop }, drop] = useDrop({
    accept: "Item",
    drop: (i,m) => { i.cut(); addItem({...i, new: true},m) }
  });

  return(
    <div id={name}>
      <h1 ref={drop}>{name}</h1>
      <div class="list">
        { items.map((item, index) => <Item item={item} cutItem={cutItemAt(index)} insertItem={insertItemAt(index)} /> )}
      </div>
    </div>
  );
}

const Item = ({item, cutItem, insertItem}) => {
  const [{ isDragging }, drag] = useDrag({
    type: "Item",
    item: { ...item, cut: cutItem }
  });
  const [{isOver, canDrop }, drop] = useDrop({
    accept: "Item",
    drop: (i,m) => { i.cut(); insertItem(i,m) }
  });
  return(<div class="item" key={item.key} ref={drag}>
           <div ref={drop}>{item.text}</div>
         </div>)
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
      <input type="text" name="itemText" id="itemText" placeholder="Clean placeholders" />
      <button><span>Submit</span></button>
    </form>
  )
};

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);

root.render(<App />);
