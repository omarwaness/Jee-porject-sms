<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Enrollment Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 min-h-screen text-slate-900 font-sans">

<jsp:include page="/navbar.jsp" />

<main class="container mx-auto max-w-7xl px-4 py-10">

    <div class="mb-8 flex justify-between items-end">
        <div>
            <h1 class="text-3xl font-bold text-slate-900 tracking-tight">Enrollment Manager</h1>
            <p class="text-slate-500 mt-1">Manage student enrollments by course.</p>
        </div>
    </div>

    <div class="space-y-6">
        <c:forEach var="course" items="${courses}">

            <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
                <div class="bg-slate-50 px-6 py-4 border-b border-slate-200 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                    <div>
                        <h2 class="text-lg font-bold text-slate-800">${course.name}</h2>
                        <p class="text-sm text-slate-500">Instructor: ${course.instructor} &bull; Credits: ${course.credits}</p>
                    </div>

                    <button onclick="openEnrollModal('${course.id}', '${course.name}')"
                            class="flex items-center gap-2 bg-cyan-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium transition shadow-sm">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
                        Enroll Student
                    </button>
                </div>

                <div class="px-6 py-4">
                    <c:set var="courseEnrollments" value="${enrollmentsMap[course.id]}" />

                    <c:choose>
                        <c:when test="${not empty courseEnrollments}">
                            <div class="overflow-x-auto">
                                <table class="w-full text-sm text-left">
                                    <thead class="text-xs text-slate-500 uppercase bg-white border-b border-slate-100">
                                    <tr>
                                        <th class="py-2">Student Name</th>
                                        <th class="py-2">Enrollment Date</th>
                                        <th class="py-2">Grade</th>
                                    </tr>
                                    </thead>
                                    <tbody class="divide-y divide-slate-50">
                                    <c:forEach var="enrollment" items="${courseEnrollments}">
                                        <tr>
                                            <td class="py-3 font-medium text-slate-900">
                                                    ${enrollment.studentName}
                                            </td>
                                            <td class="py-3 text-slate-500">${enrollment.enrollmentDate}</td>
                                            <td class="py-3">
                                                    <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium
                                                        ${empty enrollment.grade ? 'bg-slate-100 text-slate-600' : 'bg-green-100 text-green-700'}">
                                                            ${empty enrollment.grade ? 'N/A' : enrollment.grade}
                                                    </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="py-4 text-center">
                                <p class="text-sm text-slate-400 italic">No students currently enrolled in this course.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </c:forEach>
    </div>

</main>

<div id="enrollModal" class="hidden fixed inset-0 z-50 overflow-y-auto" aria-labelledby="modal-title" role="dialog" aria-modal="true">
    <div class="fixed inset-0 bg-slate-900 bg-opacity-75 transition-opacity" onclick="closeModal()"></div>

    <div class="flex min-h-full items-center justify-center p-4 text-center sm:p-0">
        <div class="relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg">

            <form action="enrollments" method="post">
                <input type="hidden" name="action" value="enroll">
                <input type="hidden" name="courseId" id="modalCourseId">

                <div class="bg-white px-4 pb-4 pt-5 sm:p-6 sm:pb-4">
                    <div class="sm:flex sm:items-start">
                        <div class="mx-auto flex h-12 w-12 flex-shrink-0 items-center justify-center rounded-full bg-indigo-100 sm:mx-0 sm:h-10 sm:w-10">
                            <svg class="h-6 w-6 text-indigo-600" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M19 7.5v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
                            </svg>
                        </div>
                        <div class="mt-3 text-center sm:ml-4 sm:mt-0 sm:text-left w-full">
                            <h3 class="text-base font-semibold leading-6 text-slate-900" id="modalTitle">Enroll Student</h3>
                            <div class="mt-2">
                                <p class="text-sm text-slate-500 mb-4">Select a student to enroll in <span id="courseNameDisplay" class="font-bold text-slate-800"></span>.</p>

                                <label class="block text-sm font-medium text-slate-700 mb-1">Select Student</label>
                                <select name="studentId" required class="block w-full rounded-md border-0 py-2 text-slate-900 shadow-sm ring-1 ring-inset ring-slate-300 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6">
                                    <option value="" disabled selected>-- Choose a student --</option>
                                    <c:forEach var="s" items="${allStudents}">
                                        <option value="${s.id}">${s.name} (${s.email})</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bg-slate-50 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6">
                    <button type="submit" class="inline-flex w-full justify-center rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 sm:ml-3 sm:w-auto">Confirm Enrollment</button>
                    <button type="button" onclick="closeModal()" class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-slate-900 shadow-sm ring-1 ring-inset ring-slate-300 hover:bg-slate-50 sm:mt-0 sm:w-auto">Cancel</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function openEnrollModal(courseId, courseName) {
        document.getElementById('modalCourseId').value = courseId;
        document.getElementById('courseNameDisplay').textContent = courseName;
        document.getElementById('enrollModal').classList.remove('hidden');
    }

    function closeModal() {
        document.getElementById('enrollModal').classList.add('hidden');
    }
</script>

</body>
</html>