// src/pages/Dashboard.jsx
import { useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { isAuthenticated } from '../utils/auth'

function Dashboard() {
  const navigate = useNavigate()

  useEffect(() => {
    const token = localStorage.getItem('token')
    if (!isAuthenticated()) {
      navigate('/login')
    }
  }, [navigate])

  return (
    <div>
      <h2>Welcome to your Dashboard</h2>
      <p>This is a protected route. You’re logged in.</p>
    </div>
  )
}

export default Dashboard
