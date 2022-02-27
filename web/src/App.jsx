import { useState } from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Home from "./Pages";
import Cantio from "./Pages/App";
import Browse from "./Pages/App/Browse";
import Create from "./Pages/App/Create";
import Registration from "./Pages/App/Registration";
import SongView from "./Pages/App/SongView";

function App() {
  const [count, setCount] = useState(0);

  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/app">
          <Route path="" element={<Cantio />} />
          <Route path="registration" element={<Registration />} />
          <Route path="create" element={<Create />} />
          <Route path="browse" element={<Browse />} />
          <Route path="song/:id" element={<SongView />} />
        </Route>
      </Routes>
    </Router>
  );
}

export default App;
