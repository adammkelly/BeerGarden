import React from 'react';
import beer from './beer.svg';
import { BeerView } from './Beer'
import './App.css';
import Button from 'react-bootstrap/Button';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      error: null,
      isLoaded: false,
      item: {}
    };
    this.getRandomBeer = this.getRandomBeer.bind(this)
    this.resetView = this.resetView.bind(this)
  }

  resetView() {
    this.setState({
      isLoaded: false
    });
  }

  getRandomBeer() {
    fetch("http://localhost:8080/beers/random")
      .then(res => res.json())
      .then(
        (result) => {
          this.setState({
            isLoaded: true,
            item: result.response
          });
        },
        // Note: it's important to handle errors here
        // instead of a catch() block so that we don't swallow
        // exceptions from actual bugs in components.
        (error) => {
          this.setState({
            isLoaded: true,
            error
          });
        }
      )
    }

    render () {
      return (
        <div className="App">
          <header className="App-header">
            <img src={beer} className="Beer-logo" alt="beer" />
            <MyButton handleClick={this.getRandomBeer} var="primary" text="Get me a beer!"/>
            <MyButton handleClick={this.resetView} var="secondary" text="Reset"/>
            <BeerView item={this.state.item} state={this.state.isLoaded}/>
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
          <Button onClick={this.props.handleClick}
            variant={this.props.var}>{this.props.text}</Button>
        </div>
      );
    }
  }

export default App;
