import React from 'react'
import Container from 'react-bootstrap/Container';
import { alignPropType } from 'react-bootstrap/esm/types';
import Navbar from 'react-bootstrap/Navbar';


function Navigate() {
  return (
    <div>
        <Navbar className="bg-body-tertiary">
      <Container>
        <Navbar.Brand href="#home">Search
        </Navbar.Brand>
        <Navbar.Text>
          <div className="bbc-logo">
          <h1>B B C</h1>
          </div>
        </Navbar.Text>
        <Navbar.Toggle />
        <Navbar.Collapse className="justify-content-center">

          </Navbar.Collapse>
        <Navbar.Collapse className="justify-content-end">
          <Navbar.Text>
          Register Sign In
          </Navbar.Text>
        </Navbar.Collapse>
      </Container>
    </Navbar>
    </div>
  )
}

export default Navigate