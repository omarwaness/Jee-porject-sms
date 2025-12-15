<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Student Management</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-slate-50 min-h-screen text-slate-900 font-sans">

<jsp:include page="/navbar.jsp" />

<main class="container mx-auto max-w-7xl px-4 py-10">

  <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
    <div>
      <h1 class="text-3xl font-bold text-slate-900 tracking-tight">Students</h1>
      <p class="text-slate-500 mt-1">Manage student profiles and academic records.</p>
    </div>

    <div class="flex w-full md:w-auto gap-3">
      <div class="relative w-full md:w-64">
        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
          <svg class="h-5 w-5 text-slate-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
          </svg>
        </div>
        <input type="text" id="searchInput" onkeyup="filterStudents()" placeholder="Search students..."
               class="block w-full pl-10 pr-3 py-2 border border-slate-300 rounded-md leading-5 bg-white placeholder-slate-400 focus:outline-none focus:border-cyan-500 focus:ring-1 focus:ring-cyan-500 sm:text-sm transition duration-150">
      </div>

      <button onclick="openAddForm()"
              class="bg-cyan-600 hover:bg-cyan-700 text-white font-medium py-2 px-4 rounded-md shadow-sm flex items-center transition duration-150">
        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path></svg>
        Add Student
      </button>
    </div>
  </div>

  <div id="studentFormContainer" class="hidden mb-10">
    <div class="bg-white rounded-lg shadow-md border border-slate-200 p-6">
      <div class="flex justify-between items-center mb-4">
        <h2 id="formTitle" class="text-xl font-semibold text-slate-800">Add New Student</h2>
        <button onclick="closeForm()" class="text-slate-400 hover:text-slate-600">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
        </button>
      </div>
      <form action="students" method="post">
        <input type="hidden" name="action" id="formAction" value="add">
        <input type="hidden" name="id" id="studentId" value="">

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div class="md:col-span-2">
            <label class="block text-sm font-medium text-slate-700 mb-1">Full Name</label>
            <input type="text" name="name" id="inputName" required class="w-full rounded-md border-slate-300 shadow-sm focus:border-cyan-500 focus:ring-cyan-500 sm:text-sm p-2 border">
          </div>

          <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">Email Address</label>
            <input type="email" name="email" id="inputEmail" required class="w-full rounded-md border-slate-300 shadow-sm focus:border-cyan-500 focus:ring-cyan-500 sm:text-sm p-2 border">
          </div>

          <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">Major</label>
            <input type="text" name="major" id="inputMajor" placeholder="e.g. Computer Science" class="w-full rounded-md border-slate-300 shadow-sm focus:border-cyan-500 focus:ring-cyan-500 sm:text-sm p-2 border">
          </div>

          <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">GPA</label>
            <input type="number" step="0.01" min="0" max="4.0" name="gpa" id="inputGpa" class="w-full rounded-md border-slate-300 shadow-sm focus:border-cyan-500 focus:ring-cyan-500 sm:text-sm p-2 border">
          </div>

          <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">Enrollment Date</label>
            <input type="date" name="enrollmentDate" id="inputDate" required class="w-full rounded-md border-slate-300 shadow-sm focus:border-cyan-500 focus:ring-cyan-500 sm:text-sm p-2 border">
          </div>
        </div>

        <div class="mt-6 flex justify-end gap-3">
          <button type="button" onclick="closeForm()" class="px-4 py-2 bg-slate-100 text-slate-700 rounded-md hover:bg-slate-200 transition">Cancel</button>
          <button type="submit" class="px-4 py-2 bg-cyan-600 text-white rounded-md hover:bg-cyan-700 shadow-sm transition">Save Student</button>
        </div>
      </form>
    </div>
  </div>

  <c:choose>
    <c:when test="${not empty students}">
      <div id="studentGrid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

        <c:forEach var="student" items="${students}">
          <div class="student-card bg-white p-6 rounded-lg shadow-sm border border-slate-200 hover:shadow-md transition-shadow duration-200 flex flex-col justify-between"
               data-search="${student.name.toLowerCase()} ${student.email.toLowerCase()} ${student.major.toLowerCase()}">

            <div class="flex items-start justify-between mb-4">
              <div class="flex items-start space-x-3">
                <div class="h-10 w-10 rounded-full bg-cyan-100 flex items-center justify-center text-cyan-600 font-bold text-lg">
                    ${student.name.charAt(0)}
                </div>
                <div>
                  <h3 class="text-lg font-bold text-slate-900 line-clamp-1">${student.name}</h3>
                  <p class="text-sm text-slate-500">${student.email}</p>
                </div>
              </div>

              <div class="flex flex-col space-y-1">
                <button onclick="openEditForm('${student.id}', '${student.name}', '${student.email}', '${student.major}', '${student.gpa}', '${student.enrollmentDate}')"
                        class="text-slate-400 hover:text-cyan-600 transition" title="Edit">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"></path></svg>
                </button>
                <a href="students?action=delete&id=${student.id}" onclick="return confirm('Delete student profile?');"
                   class="text-slate-400 hover:text-red-600 transition" title="Delete">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                </a>
              </div>
            </div>

            <div class="border-t border-slate-100 my-3"></div>

            <div class="grid grid-cols-2 gap-4 text-sm">
              <div>
                <span class="block text-xs font-semibold text-slate-400 uppercase">Major</span>
                <span class="text-slate-800 font-medium">${student.major}</span>
              </div>
              <div>
                <span class="block text-xs font-semibold text-slate-400 uppercase">GPA</span>
                <span class="text-slate-800 font-medium ${student.gpa >= 3.5 ? 'text-green-600' : ''}">
                    ${student.gpa != null ? student.gpa : 'N/A'}
                </span>
              </div>
              <div class="col-span-2">
                <span class="block text-xs font-semibold text-slate-400 uppercase">Enrolled Since</span>
                <span class="text-slate-800">${student.enrollmentDate}</span>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>

      <div id="noResultsMessage" class="hidden bg-white p-10 rounded-lg shadow-sm border border-slate-200 text-center mt-6">
        <p class="text-slate-500">No students match your search.</p>
      </div>
    </c:when>

    <c:otherwise>
      <div class="bg-white p-12 rounded-lg shadow-sm border border-slate-200 text-center">
        <div class="bg-slate-50 rounded-full p-4 w-16 h-16 mx-auto mb-4 flex items-center justify-center">
          <svg class="h-8 w-8 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path></svg>
        </div>
        <h3 class="text-lg font-medium text-slate-900">No students found</h3>
        <p class="mt-2 text-slate-500">Add a new student to get started.</p>
        <button onclick="openAddForm()" class="mt-6 text-cyan-600 font-medium hover:text-cyan-700">Add Student &rarr;</button>
      </div>
    </c:otherwise>
  </c:choose>

</main>

<script>
  // --- SEARCH LOGIC ---
  function filterStudents() {
    const input = document.getElementById('searchInput');
    const filter = input.value.toLowerCase();
    const grid = document.getElementById('studentGrid');
    const cards = grid.getElementsByClassName('student-card');
    const noResults = document.getElementById('noResultsMessage');

    let visibleCount = 0;

    for (let i = 0; i < cards.length; i++) {
      const searchData = cards[i].getAttribute('data-search');
      if (searchData.includes(filter)) {
        cards[i].style.display = "";
        visibleCount++;
      } else {
        cards[i].style.display = "none";
      }
    }

    if (visibleCount === 0 && cards.length > 0) noResults.classList.remove('hidden');
    else noResults.classList.add('hidden');
  }

  // --- FORM LOGIC ---
  const formContainer = document.getElementById('studentFormContainer');
  const formTitle = document.getElementById('formTitle');
  const formAction = document.getElementById('formAction');
  const studentIdInput = document.getElementById('studentId');

  // Inputs
  const inputName = document.getElementById('inputName');
  const inputEmail = document.getElementById('inputEmail');
  const inputMajor = document.getElementById('inputMajor');
  const inputGpa = document.getElementById('inputGpa');
  const inputDate = document.getElementById('inputDate');

  function openAddForm() {
    formTitle.textContent = "Add New Student";
    formAction.value = "add";
    studentIdInput.value = "";

    // Clear inputs
    inputName.value = "";
    inputEmail.value = "";
    inputMajor.value = "";
    inputGpa.value = "";
    // Default date to today
    inputDate.value = new Date().toISOString().split('T')[0];

    formContainer.classList.remove('hidden');
    inputName.focus();
  }

  function openEditForm(id, name, email, major, gpa, date) {
    formTitle.textContent = "Edit Student";
    formAction.value = "update";
    studentIdInput.value = id;

    inputName.value = name;
    inputEmail.value = email;
    inputMajor.value = major;
    inputGpa.value = (gpa === 'null' || gpa === '') ? '' : gpa;
    inputDate.value = date;

    formContainer.classList.remove('hidden');
    formContainer.scrollIntoView({ behavior: 'smooth' });
  }

  function closeForm() {
    formContainer.classList.add('hidden');
  }
</script>

</body>
</html>