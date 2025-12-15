<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-slate-50 min-h-screen text-slate-900 font-sans">

<jsp:include page="/navbar.jsp" />

<main class="container mx-auto max-w-7xl px-4 py-10">

    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <div>
            <h1 class="text-3xl font-bold text-slate-900 tracking-tight">Courses</h1>
            <p class="text-slate-500 mt-1">Manage curriculum and class capacities.</p>
        </div>

        <div class="flex w-full md:w-auto gap-3">
            <div class="relative w-full md:w-64">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <svg class="h-5 w-5 text-slate-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                </div>
                <input type="text" id="searchInput" onkeyup="filterCourses()" placeholder="Search..."
                       class="block w-full pl-10 pr-3 py-2 border border-slate-300 rounded-md leading-5 bg-white placeholder-slate-400 focus:outline-none focus:border-cyan-500 focus:ring-1 focus:ring-cyan-500 sm:text-sm transition duration-150">
            </div>

            <button onclick="openAddForm()"
                    class="bg-cyan-600 hover:bg-cyan-700 text-white font-medium py-2 px-4 rounded-md shadow-sm flex items-center transition duration-150">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
                Add Course
            </button>
        </div>
    </div>

    <div id="courseFormContainer" class="hidden mb-10">
        <div class="bg-white rounded-lg shadow-md border border-slate-200 p-6">
            <div class="flex justify-between items-center mb-4">
                <h2 id="formTitle" class="text-xl font-semibold text-slate-800">Add New Course</h2>
                <button onclick="closeForm()" class="text-slate-400 hover:text-slate-600">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                </button>
            </div>
            <form action="courses" method="post">
                <input type="hidden" name="action" id="formAction" value="add">
                <input type="hidden" name="id" id="courseId" value="">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Course Name</label>
                        <input type="text" name="name" id="inputName" required class="w-full rounded-md border-slate-300 shadow-sm focus:border-cyan-500 focus:ring-cyan-500 sm:text-sm p-2 border">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Instructor</label>
                        <input type="text" name="instructor" id="inputInstructor" required class="w-full rounded-md border-slate-300 shadow-sm focus:border-cyan-500 focus:ring-cyan-500 sm:text-sm p-2 border">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Credits</label>
                        <input type="number" name="credits" id="inputCredits" required min="1" class="w-full rounded-md border-slate-300 shadow-sm focus:border-cyan-500 focus:ring-cyan-500 sm:text-sm p-2 border">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-1">Capacity</label>
                        <input type="number" name="capacity" id="inputCapacity" required min="1" class="w-full rounded-md border-slate-300 shadow-sm focus:border-cyan-500 focus:ring-cyan-500 sm:text-sm p-2 border">
                    </div>
                </div>
                <div class="mt-6 flex justify-end gap-3">
                    <button type="button" onclick="closeForm()" class="px-4 py-2 bg-slate-100 text-slate-700 rounded-md hover:bg-slate-200 transition">Cancel</button>
                    <button type="submit" class="px-4 py-2 bg-cyan-600 text-white rounded-md hover:bg-cyan-700 shadow-sm transition">Save Course</button>
                </div>
            </form>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty courses}">
            <div id="courseGrid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

                <c:forEach var="course" items="${courses}">
                    <div class="course-card bg-white p-6 rounded-lg shadow-sm border border-slate-200 hover:shadow-md transition-shadow duration-200 flex flex-col justify-between group"
                         data-search="${course.name.toLowerCase()} ${course.instructor.toLowerCase()}">

                        <div class="flex items-start justify-between mb-4">
                            <div>
                                <h3 class="text-lg font-bold text-slate-900 line-clamp-1">${course.name}</h3>
                                <div class="flex items-center mt-1 text-sm text-slate-500">
                                    <svg class="w-4 h-4 mr-1 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                                        ${course.instructor}
                                </div>
                            </div>
                            <div class="flex space-x-1">
                                <button onclick="openEditForm('${course.id}', '${course.name}', '${course.instructor}', '${course.credits}', '${course.capacity}')"
                                        class="p-2 text-slate-400 hover:text-cyan-600 hover:bg-cyan-50 rounded-full transition">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                                </button>
                                <a href="courses?action=delete&id=${course.id}" onclick="return confirm('Are you sure?');"
                                   class="p-2 text-slate-400 hover:text-red-600 hover:bg-red-50 rounded-full transition">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                                </a>
                            </div>
                        </div>
                        <div class="border-t border-slate-100 my-3"></div>
                        <div class="flex items-center justify-between mt-auto">
                            <div class="text-center">
                                <span class="block text-xs font-semibold text-slate-400 uppercase tracking-wider">Credits</span>
                                <span class="block text-slate-800 font-bold text-lg">${course.credits}</span>
                            </div>
                            <div class="text-center">
                                <span class="block text-xs font-semibold text-slate-400 uppercase tracking-wider">Capacity</span>
                                <span class="block text-slate-800 font-bold text-lg">${course.capacity}</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div id="noResultsMessage" class="hidden bg-white p-10 rounded-lg shadow-sm border border-slate-200 text-center mt-6">
                <svg class="mx-auto h-12 w-12 text-slate-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                </svg>
                <h3 class="mt-2 text-sm font-medium text-slate-900">No matching courses found</h3>
                <p class="mt-1 text-sm text-slate-500">Try adjusting your search terms.</p>
            </div>
        </c:when>

        <c:otherwise>
            <div class="bg-white p-12 rounded-lg shadow-sm border border-slate-200 text-center">
                <p class="text-slate-500">No courses available in the system.</p>
            </div>
        </c:otherwise>
    </c:choose>

</main>

<script>
    // --- SEARCH FILTER FUNCTION ---
    function filterCourses() {
        const input = document.getElementById('searchInput');
        const filter = input.value.toLowerCase();
        const grid = document.getElementById('courseGrid');
        const cards = grid.getElementsByClassName('course-card');
        const noResults = document.getElementById('noResultsMessage');

        let visibleCount = 0;

        for (let i = 0; i < cards.length; i++) {
            // We set data-search="${name} ${instructor}" in the HTML
            const searchData = cards[i].getAttribute('data-search');

            if (searchData.includes(filter)) {
                cards[i].style.display = ""; // Show
                visibleCount++;
            } else {
                cards[i].style.display = "none"; // Hide
            }
        }

        // Toggle "No Results" message
        if (visibleCount === 0 && cards.length > 0) {
            noResults.classList.remove('hidden');
        } else {
            noResults.classList.add('hidden');
        }
    }

    // --- FORM LOGIC (Existing) ---
    const formContainer = document.getElementById('courseFormContainer');
    const formTitle = document.getElementById('formTitle');
    const formAction = document.getElementById('formAction');
    const courseIdInput = document.getElementById('courseId');
    const inputName = document.getElementById('inputName');
    const inputInstructor = document.getElementById('inputInstructor');
    const inputCredits = document.getElementById('inputCredits');
    const inputCapacity = document.getElementById('inputCapacity');

    function openAddForm() {
        formTitle.textContent = "Add New Course";
        formAction.value = "add";
        courseIdInput.value = "";
        inputName.value = "";
        inputInstructor.value = "";
        inputCredits.value = "";
        inputCapacity.value = "";
        formContainer.classList.remove('hidden');
        inputName.focus();
    }

    function openEditForm(id, name, instructor, credits, capacity) {
        formTitle.textContent = "Edit Course";
        formAction.value = "update";
        courseIdInput.value = id;
        inputName.value = name;
        inputInstructor.value = instructor;
        inputCredits.value = credits;
        inputCapacity.value = capacity;
        formContainer.classList.remove('hidden');
        formContainer.scrollIntoView({ behavior: 'smooth' });
    }

    function closeForm() {
        formContainer.classList.add('hidden');
    }
</script>

</body>
</html>