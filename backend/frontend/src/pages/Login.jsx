import { useState } from 'react'
import axios from 'axios'
import { useNavigate } from 'react-router-dom'
import './Login.css'

function Login() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [message, setMessage] = useState('')
  const navigate = useNavigate()

  const handleLogin = async (e) => {
    e.preventDefault()
    try {
      const res = await axios.post('http://localhost:3000/login', {
        email,
        password,
      })
      localStorage.setItem('token', res.data.token)
      setMessage('Login successful!')
      navigate('/dashboard')
    } catch (err) {
      setMessage(err.response?.data?.error || 'Login failed')
    }
  }

  return (
    <div className="login-container">
      <form className="login-form" onSubmit={handleLogin}>
        <h2 className="login-title">TaskFlow</h2>
         <h2 className="login-title">Welcome Back</h2>

        <div className="input-group">
          <input
            type="email"
            required
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
          <label>Email</label>
        </div>

        <div className="input-group">
          <input
            type="password"
            required
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
          <label>Password</label>
        </div>

        <button type="submit" className="login-btn">Login</button>
        <p className="login-msg">{message}</p>

        <div className="register-redirect">
          Don’t have an account?
          <button type="button" onClick={() => navigate('/register')}>
            Register
          </button>
        </div>
      </form>
    </div>
  )
}

export default Login
