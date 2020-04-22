import React from 'react';
import beer from './beer.svg';
import './App.css';
import Button from 'react-bootstrap/Button';

function GetRandomBeer() {
  console.log('STARTED HOOK - Figure oout fetch')
}

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = { };
  }

    render () {
      return (
        <div className="App">
          <header className="App-header">
            <img src={beer} className="Beer-logo" alt="beer" />
            <p>
              Edit <code>src/App.js</code> and save to reload.
            </p>
            <a
              className="App-link"
              href="https://reactjs.org"
              target="_blank"
              rel="noopener noreferrer"
            >
              Learn React
            </a>
            <MyButton handleClick={GetRandomBeer}/>
          </header>
        </div>);
    }
  }

  class MyButton extends React.Component {
    constructor(props) {
      super(props);
      console.log(props)
    }

    render() {
      return (
        <div>
          <Button onClick={this.props.handleClick} variant="primary">AAAAAH!</Button>
        </div>
      );
    }
  }

export default App;
