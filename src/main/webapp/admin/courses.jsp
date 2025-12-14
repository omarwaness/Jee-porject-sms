<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Manage Courses</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 min-h-screen">

<jsp:include page="/navbar.jsp" />

<main class="container mx-auto max-w-7xl px-4 py-10">
    <header class="flex justify-between items-center mb-8">
        <h1 class="text-3xl font-bold text-slate-900 tracking-tight">Course Management</h1>

        <button id="add-course-btn"
                class="bg-cyan-600 text-white px-4 py-2 rounded-md hover:bg-cyan-700 transition duration-150 flex items-center shadow-md">
            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
            Add New Course
        </button>
    </header>

    <div id="alert-container" class="fixed top-20 right-5 z-50 space-y-3">
    </div>

    <div id="courses-list" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        <div class="p-6 text-center text-slate-500 col-span-full">Loading courses...</div>
    </div>
</main>

<div id="form-modal" class="fixed inset-0 bg-black bg-opacity-50 z-40 hidden flex items-start justify-center pt-10 pb-10 overflow-y-auto">
    <div class="w-full max-w-2xl bg-white p-6 rounded-xl shadow-2xl border border-slate-200 transform transition-all duration-300">
        <h2 id="modal-title" class="text-2xl font-semibold text-slate-900 mb-6 border-b pb-2">Course Details</h2>

        <form id="course-form" class="space-y-4">
            <input type="hidden" id="course-id">

            <div>
                <label for="name" class="block text-sm font-medium text-slate-700">Course Name</label>
                <input type="text" id="name" name="name" placeholder="e.g., Distributed Systems" required
                       class="mt-1 block w-full px-3 py-2 border border-slate-300 rounded-md shadow-sm focus:outline-none focus:ring-cyan-500 focus:border-cyan-500">
            </div>

            <div>
                <label for="instructor" class="block text-sm font-medium text-slate-700">Instructor</label>
                <input type="text" id="instructor" name="instructor" placeholder="e.g., Dr. Smith" required
                       class="mt-1 block w-full px-3 py-2 border border-slate-300 rounded-md shadow-sm focus:outline-none focus:ring-cyan-500 focus:border-cyan-500">
            </div>

            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label for="credits" class="block text-sm font-medium text-slate-700">Credits</label>
                    <input type="number" id="credits" name="credits" placeholder="e.g., 3" min="1" required
                           class="mt-1 block w-full px-3 py-2 border border-slate-300 rounded-md shadow-sm focus:outline-none focus:ring-cyan-500 focus:border-cyan-500">
                </div>

                <div>
                    <label for="capacity" class="block text-sm font-medium text-slate-700">Capacity</label>
                    <input type="number" id="capacity" name="capacity" placeholder="e.g., 40" min="1" required
                           class="mt-1 block w-full px-3 py-2 border border-slate-300 rounded-md shadow-sm focus:outline-none focus:ring-cyan-500 focus:border-cyan-500">
                </div>
            </div>

            <div class="pt-4 flex justify-end space-x-3">
                <button type="button" onclick="closeModal()"
                        class="px-4 py-2 text-sm font-medium border border-slate-300 rounded-md text-slate-700 hover:bg-slate-100 transition">
                    Cancel
                </button>
                <button type="submit" id="submit-btn"
                        class="px-4 py-2 text-sm font-medium text-white bg-cyan-600 rounded-md hover:bg-cyan-700 transition">
                    Save Course
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    const API_ENDPOINT = "http://localhost:8080/JEE_PROJECT_war_exploded/api/courses";
    const coursesList = document.getElementById('courses-list');
    const formModal = document.getElementById('form-modal');
    const courseForm = document.getElementById('course-form');
    const modalTitle = document.getElementById('modal-title');
    const alertContainer = document.getElementById('alert-container');

    // --- UI Functions ---

    /** Shows a success or failure notification. */
    function showAlert(message, type = 'success') {
        const color = type === 'success' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700';
        const icon = type === 'success' ?
            '<svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>' :
            '<svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>';

        const alert = document.createElement('div');
        alert.className = `${color} p-4 rounded-lg shadow-lg flex items-center transition duration-300 ease-in-out transform w-80`;
        alert.innerHTML = `${icon} <span class="text-sm font-medium">${message}</span>`;

        alertContainer.prepend(alert);

        // Auto-dismiss alert after 4 seconds
        setTimeout(() => {
            alert.classList.add('opacity-0');
            setTimeout(() => alert.remove(), 300);
        }, 4000);
    }

    /** Opens the modal for adding or editing a course. */
    function openModal(course = null) {
        courseForm.reset();
        document.getElementById('course-id').value = '';

        if (course) {
            // Populate for Edit
            modalTitle.textContent = 'Edit Course: ' + course.name;
            document.getElementById('course-id').value = course.id;
            document.getElementById('name').value = course.name;
            document.getElementById('instructor').value = course.instructor;
            document.getElementById('credits').value = course.credits;
            document.getElementById('capacity').value = course.capacity;
        } else {
            // Setup for Add
            modalTitle.textContent = 'Add New Course';
        }
        formModal.classList.remove('hidden');
    }

    /** Closes the modal. */
    function closeModal() {
        formModal.classList.add('hidden');
    }

    // --- CRUD Functions ---

    /** Fetches the list of courses from the API. */
    async function fetchCourses() {
        coursesList.innerHTML = '<div class="p-6 text-center text-slate-500 col-span-full">Loading courses...</div>';
        try {
            const response = await fetch(API_ENDPOINT);
            if (!response.ok) throw new Error("Failed to fetch courses.");

            const courses = await response.json();
            renderCourses(courses);
        } catch (error) {
            console.error('Error fetching courses:', error);
            coursesList.innerHTML = '<div class="p-6 text-center text-red-600 col-span-full">Could not load courses. Check API server status.</div>';
            showAlert("Could not connect to API server.", 'fail');
        }
    }

    /** Handles course creation (POST) or update (PUT). */
    async function saveCourse(event) {
        event.preventDefault();

        const id = document.getElementById('course-id').value;
        const method = id ? 'PUT' : 'POST';
        const url = id ? `${API_ENDPOINT}/${id}` : API_ENDPOINT;

        // Gather data from the form fields
        const courseData = {
            // Ensure id is only included in PUT if your API requires it in the body
            // id: id ? parseInt(id) : undefined,
            name: document.getElementById('name').value,
            instructor: document.getElementById('instructor').value,
            credits: parseInt(document.getElementById('credits').value),
            capacity: parseInt(document.getElementById('capacity').value)
        };

        try {
            const response = await fetch(url, {
                method: method,
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(courseData)
            });

            if (!response.ok) {
                // Attempt to get specific error message from the response body
                const errorDetails = await response.text();
                throw new Error(errorDetails || `Failed with status ${response.status}`);
            }

            showAlert(`Course '${courseData.name}' successfully ${method === 'PUT' ? 'updated' : 'added'}.`, 'success');
            closeModal();
            fetchCourses(); // Refresh the list
        } catch (error) {
            console.error('Save error:', error);
            showAlert(`Failed to save course. Error: ${error.message}`, 'fail');
        }
    }

    /** Handles course deletion (DELETE) with confirmation. */
    async function deleteCourse(id, name) {
        // Confirmation Message
        if (!confirm(`Are you sure you want to delete the course: "${name}"? This action cannot be undone.`)) {
            return;
        }

        try {
            const response = await fetch(`${API_ENDPOINT}/${id}`, {
                method: 'DELETE'
            });

            if (!response.ok) {
                const errorDetails = await response.text();
                throw new Error(errorDetails || `Failed with status ${response.status}`);
            }

            showAlert(`Course '${name}' successfully deleted.`, 'success');
            fetchCourses(); // Refresh the list
        } catch (error) {
            console.error('Delete error:', error);
            showAlert(`Failed to delete course. Error: ${error.message}`, 'fail');
        }
    }

    // --- Rendering ---

    /** Renders the course cards to the DOM. */
    function renderCourses(courses) {
        coursesList.innerHTML = '';
        if (courses.length === 0) {
            coursesList.innerHTML = '<div class="p-6 text-center text-slate-500 col-span-full">No courses found in the system.</div>';
            return;
        }

        courses.forEach(course => {
            const card = document.createElement('div');
            card.className = 'bg-white p-6 rounded-xl shadow-lg border border-slate-200 hover:shadow-xl transition duration-200';

            // We use JSON.stringify and .replace to pass the full course object cleanly to the openModal function
            const courseJsonString = JSON.stringify(course).replace(/"/g, '&quot;');

            card.innerHTML = `
                    <div class="flex items-center justify-between mb-2">
                        <span class="text-xs font-semibold text-slate-500 uppercase tracking-wider">ID: ${course.id}</span>
                        <span class="text-xs font-semibold text-cyan-600 border border-cyan-200 bg-cyan-50 px-2 py-0.5 rounded-full">${course.credits} Credits</span>
                    </div>
                    <h3 class="text-xl font-bold text-slate-900 mb-3">${course.name}</h3>

                    <div class="space-y-1 text-sm text-slate-700">
                        <p><span class="font-medium">Instructor:</span> ${course.instructor}</p>
                        <p><span class="font-medium">Capacity:</span> ${course.capacity}</p>
                    </div>

                    <div class="mt-5 pt-4 border-t border-slate-100 flex justify-end space-x-3">
                        <button onclick="openModal(${courseJsonString})"
                                class="flex items-center text-sm px-3 py-1 border border-slate-300 rounded-md text-slate-600 hover:bg-slate-50 transition">
                            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.536z"></path></svg>
                            Edit
                        </button>
                        <button onclick="deleteCourse(${course.id}, '${course.name}')"
                                class="flex items-center text-sm px-3 py-1 border border-red-300 rounded-md text-red-600 hover:bg-red-50 transition">
                            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                            Delete
                        </button>
                    </div>
                `;
            coursesList.appendChild(card);
        });
    }

    // --- Initialization ---

    document.getElementById('add-course-btn').addEventListener('click', () => openModal());
    courseForm.addEventListener('submit', saveCourse);

    // Fetch courses on page load
    document.addEventListener('DOMContentLoaded', fetchCourses);

</script>
</body>
</html>