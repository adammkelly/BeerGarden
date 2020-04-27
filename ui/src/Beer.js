import React from 'react';

export class BeerView extends React.Component {

  render() {
    const styleObj = {
      fontSize: 14,
      color: "#4a54f1",
      textAlign: "center",
      paddingTop: "100px",
    };
    console.log(this.props);
    const item = this.props.item;
    const state = this.props.state;
    if (state) {
      return (
        <div style={styleObj}>
          <h1>{item.Title} - {item.Size} ({item.Percent}%)</h1>
          <p>{item.Description}</p>
          <p>ref: {item.UUID}</p>
        </div>
      );
    } else {
      return <div></div>;
    }
  }
}
