import React, { useEffect } from "react";
import { Container, ListGroup, Form } from "react-bootstrap";
import { ResetButton } from "./uiComponent";
import axios from "axios";

type TodoItem = {
  id: number;
  title: string;
  checked: boolean;
  priority: string;
};

type Props = {
  todoItems: TodoItem[];
};





const TodoList: React.FC<Props> = ({ todoItems }) => {

  const priorityColor = (value: any): {backgroundColor: string} => {

    switch (value) {
      case "low": return {backgroundColor:  "#FDF9BB"}
      case "high": return { backgroundColor: "#FDBBBB"}
      default: return {backgroundColor: "#E1F5C8"}
    }

  }

  useEffect(() => {
    const token = document.querySelector(
      "[name=csrf-token]"
    ) as HTMLMetaElement;
    axios.defaults.headers.common["X-CSRF-TOKEN"] = token.content;
  }, []);

  const checkBoxOnCheck = (
    e: React.ChangeEvent<HTMLInputElement>,
    todoItemId: number
  ): void => {
    e.preventDefault();
    axios.post("/todo", {
      id: todoItemId,
      checked: e.target.checked,
    }).then(() => location.reload())

  };


  const resetButtonOnClick = (): void => {
    axios.post("/reset").then(() => location.reload());
  };



  return (
    <Container>
      <h3>2022 Wish List</h3>
      <ListGroup>
        {todoItems.map((todo) => (
          <ListGroup.Item key={todo.id}  
           style={priorityColor(todo.priority)}
          className="item-group"
          >
            <Form.Check
              type="checkbox"
              label={todo.title}
              checked={todo.checked}
              onChange={(e) => checkBoxOnCheck(e, todo.id)}
            />
          </ListGroup.Item>
        ))}
        <ResetButton onClick={resetButtonOnClick}>Reset</ResetButton>
      </ListGroup>
    </Container>
  );
};

export default TodoList;
