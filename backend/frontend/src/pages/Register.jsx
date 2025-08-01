import { useState } from 'react'
import axios from 'axios'
import { useNavigate } from 'react-router-dom'
import './Register.css'

function Register() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [message, setMessage] = useState('')
  const navigate = useNavigate()

  const handleRegister = async (e) => {
    e.preventDefault()
    try {
      const res = await axios.post('http://localhost:3000/register', {
        email,
        password,
      })
      localStorage.setItem('token', res.data.token)
      setMessage('Registration successful!')
      navigate('/login')
    } catch (err) {
      setMessage(err.response?.data?.errors?.[0] || 'Registration failed')
    }
  }

  return (
    <div className="register-wrapper">
      <form className="register-form" onSubmit={handleRegister}>
        <h2>Create Account</h2>
        <input
          type="email"
          placeholder="Email address"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
        <input
          type="password"
          placeholder="Choose a password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
        />
        <button type="submit">Register</button>
        <p className="register-msg">{message}</p>
        <div className="login-redirect">
          Already have an account?
          <button type="button" onClick={() => navigate('/login')}>
            Login
          </button>
        </div>
      </form>
    </div>
  )
}

export default Register
