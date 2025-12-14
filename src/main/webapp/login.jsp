<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SIS Login</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    /* Base styles for a professional container */
    .login-container {
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      background-color: #f8fafc; /* Slate-50 background */
    }
  </style>
</head>
<body class="login-container">

<div class="w-full max-w-sm p-8 bg-white rounded-xl shadow-lg border border-slate-200">
  <header class="mb-6">
    <h1 class="text-3xl font-bold text-slate-900 tracking-tight">Welcome Back</h1>
    <p class="text-sm text-slate-500 mt-1">
      Please enter your credentials to access the Student Information System.
    </p>
  </header>

  <div class="mb-6 border-b border-slate-200">
    <ul class="flex -mb-px text-sm font-medium text-center" role="tablist">
      <li class="mr-2" role="presentation">
        <button id="student-tab" type="button" role="tab" aria-selected="true"
                class="inline-flex items-center justify-center p-3 border-b-2 border-transparent text-slate-500 hover:text-slate-700 hover:border-slate-300 transition duration-150 ease-in-out">
          <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
          Student
        </button>
      </li>
      <li class="mr-2" role="presentation">
        <button id="admin-tab" type="button" role="tab" aria-selected="false"
                class="inline-flex items-center justify-center p-3 border-b-2 border-transparent text-slate-500 hover:text-slate-700 hover:border-slate-300 transition duration-150 ease-in-out">
          <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.345 2.572-1.065z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>
          Administrator
        </button>
      </li>
    </ul>
  </div>

  <% if (request.getAttribute("errorMessage") != null) { %>
  <div class="p-3 mb-4 text-sm text-red-700 bg-red-100 rounded-lg" role="alert">
    <%= request.getAttribute("errorMessage") %>
  </div>
  <% } %>


  <form action="LoginServlet" method="POST">
    <input type="hidden" id="role-input" name="role" value="student">

    <div class="mb-4">
      <label for="username" class="block mb-2 text-sm font-medium text-slate-700" id="username-label">
        Email
      </label>
      <div class="relative">
        <input type="email" id="username" name="username"
               class="w-full px-3 py-2 border border-slate-300 rounded-md text-slate-900 placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:border-cyan-500 transition duration-150 ease-in-out"
               placeholder="e.g. student@uni.edu" required>
      </div>
    </div>

    <div class="mb-6">
      <label for="password" class="block mb-2 text-sm font-medium text-slate-700">
        Password
      </label>
      <div class="relative">
        <input type="password" id="password" name="password"
               class="w-full px-3 py-2 border border-slate-300 rounded-md text-slate-900 placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:border-cyan-500 transition duration-150 ease-in-out"
               required>
        <button type="button" onclick="togglePasswordVisibility()" class="absolute inset-y-0 right-0 flex items-center pr-3 text-slate-400 hover:text-slate-600 focus:outline-none">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.477 0 8.268 2.943 9.542 7-1.274 4.057-5.065 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg>
        </button>
      </div>
    </div>

    <button type="submit"
            class="w-full text-white bg-cyan-600 hover:bg-cyan-700 focus:ring-4 focus:outline-none focus:ring-cyan-300 font-semibold rounded-md text-base px-5 py-2.5 transition duration-150 ease-in-out">
      Sign In
    </button>
  </form>

  <footer class="mt-6 text-center text-sm text-slate-500">
    New Student?
    <span class="font-medium text-cyan-600">
                Contact administration
            </span>
  </footer>
</div>

<script>
  const studentTab = document.getElementById('student-tab');
  const adminTab = document.getElementById('admin-tab');
  const roleInput = document.getElementById('role-input');
  const usernameLabel = document.getElementById('username-label');
  const usernameInput = document.getElementById('username');

  const ACTIVE_CLASSES = 'text-cyan-600 border-cyan-600 font-semibold';
  const INACTIVE_CLASSES = 'text-slate-500 hover:text-slate-700 hover:border-slate-300';

  // Function to switch active tab styling and update hidden input
  function switchTab(role) {
    // Reset both tabs
    studentTab.classList.remove(...ACTIVE_CLASSES.split(' '));
    adminTab.classList.remove(...ACTIVE_CLASSES.split(' '));
    studentTab.classList.add(...INACTIVE_CLASSES.split(' '));
    adminTab.classList.add(...INACTIVE_CLASSES.split(' '));

    if (role === 'student') {
      // Activate Student tab
      studentTab.classList.add(...ACTIVE_CLASSES.split(' '));
      studentTab.classList.remove(...INACTIVE_CLASSES.split(' '));

      // Update Form Fields
      usernameLabel.textContent = 'Email';
      usernameInput.placeholder = 'e.g. student@uni.edu';
      roleInput.value = 'student';
    } else if (role === 'administrator') {
      // Activate Admin tab
      adminTab.classList.add(...ACTIVE_CLASSES.split(' '));
      adminTab.classList.remove(...INACTIVE_CLASSES.split(' '));

      // Update Form Fields
      usernameLabel.textContent = 'Admin Email';
      usernameInput.placeholder = 'e.g. admin@university.edu';
      roleInput.value = 'administrator';
    }
  }

  // Attach event listeners and set initial state
  studentTab.addEventListener('click', () => switchTab('student'));
  adminTab.addEventListener('click', () => switchTab('administrator'));

  // Initial state
  switchTab('student');

  // Simple function to toggle password visibility
  function togglePasswordVisibility() {
    const passwordField = document.getElementById('password');
    if (passwordField.type === 'password') {
      passwordField.type = 'text';
    } else {
      passwordField.type = 'password';
    }
  }
</script>
</body>
</html>