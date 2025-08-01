// src/axios.js
import axios from 'axios'

const instance = axios.create({
  baseURL: 'http://localhost:3000', // your Rails API
  headers: {
    'Content-Type': 'application/json'
  }
})

export default instance
