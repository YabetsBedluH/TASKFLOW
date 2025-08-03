import { useEffect, useState } from 'react'
import axios from 'axios'
import { useNavigate } from 'react-router-dom'
import './Dashboard.css'

function Dashboard() {
  const [user, setUser] = useState(null)
  const [tasks, setTasks] = useState([])
  const [newTask, setNewTask] = useState('')
  const navigate = useNavigate()
  const token = localStorage.getItem('token')

  useEffect(() => {
    if (!token) {
      navigate('/login')
      return
    }

    axios.get('http://localhost:3000/me', {
      headers: { Authorization: `Bearer ${token}` }
    }).then(res => setUser(res.data))

    axios.get('http://localhost:3000/tasks', {
      headers: { Authorization: `Bearer ${token}` }
    }).then(res => setTasks(res.data))
  }, [navigate, token])

  const addTask = async (e) => {
    e.preventDefault()
    if (!newTask.trim()) return

    try {
      const res = await axios.post('http://localhost:3000/tasks', {
        task: { title: newTask, status: 'todo' }
      }, {
        headers: { Authorization: `Bearer ${token}` }
      })

      console.log('Created task response:', res.data)
      const task = res.data
      if (task && task.id && task.status) {
        setTasks([task, ...tasks])
        setNewTask('')
      } else {
        console.error('Task object is malformed:', task)
      }
    } catch (err) {
      console.error('Add Task Error:', err)
    }
  }

  const moveTask = async (id, status) => {
    try {
      const res = await axios.put(`http://localhost:3000/tasks/${id}`, {
        task: { status }
      }, {
        headers: { Authorization: `Bearer ${token}` }
      })
      setTasks(tasks.map(t => t.id === id ? res.data : t))
    } catch (err) {
      console.error(err)
    }
  }

  const deleteTask = async (id) => {
    try {
      await axios.delete(`http://localhost:3000/tasks/${id}`, {
        headers: { Authorization: `Bearer ${token}` }
      })
      setTasks(tasks.filter(t => t.id !== id))
    } catch (err) {
      console.error(err)
    }
  }

  const renderColumn = (label, status) => (
    <div className="column" data-status={status}>
      <h3>{label}</h3>
      <div className="column-content">
        {tasks.filter(task => task.status === status).map(task => (
          <div key={task.id} className="task-card">
            <p>{task.title}</p>
            <div className="actions">
              {status !== 'todo' && <button className="action-btn todo-btn" onClick={() => moveTask(task.id, 'todo')}>To Do</button>}
              {status !== 'doing' && <button className="action-btn doing-btn" onClick={() => moveTask(task.id, 'doing')}>Doing</button>}
              {status !== 'done' && <button className="action-btn done-btn" onClick={() => moveTask(task.id, 'done')}>Done</button>}
              <button className='action-btn delete-btn' onClick={() => deleteTask(task.id)}>Delete</button>
            </div>
          </div>
        ))}
      </div>
    </div>
  )

  return (
    <div className="dashboard-container">
      <div className="header-section">
        <h1>Welcome, {user?.email}</h1>
        <div className="neon-divider"></div>
      </div>

      <form onSubmit={addTask} className="task-form">
        <div className="input-wrapper">
          <input
            type="text"
            placeholder="Enter new task..."
            value={newTask}
            onChange={(e) => setNewTask(e.target.value)}
          />
        </div>
        <button type="submit" className="add-btn">
          <span>Add Task</span>
        </button>
      </form>

      <div className="task-columns">
        {renderColumn('To Do', 'todo')}
        {renderColumn('In Progress', 'doing')}
        {renderColumn('Completed', 'done')}
      </div>
    </div>
  )
}

export default Dashboard