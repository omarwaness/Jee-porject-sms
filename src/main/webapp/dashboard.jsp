<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Horizon Tech</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-slate-50 min-h-screen text-slate-900 font-sans">

<jsp:include page="/navbar.jsp" />

<main class="container mx-auto max-w-7xl px-4 py-10">

    <div class="mb-8">
        <h1 class="text-3xl font-bold text-slate-900 tracking-tight">Dashboard Overview</h1>
        <p class="text-slate-500 mt-1">Welcome back, Administrator. Here is what's happening today.</p>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">

        <div class="bg-white p-6 rounded-xl shadow-sm border border-slate-200 flex items-center">
            <div class="p-4 rounded-full bg-cyan-50 text-cyan-600 mr-4">
                <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path></svg>
            </div>
            <div>
                <p class="text-sm font-medium text-slate-500">Total Students</p>
                <p class="text-3xl font-bold text-slate-900">${studentCount}</p>
            </div>
        </div>

        <div class="bg-white p-6 rounded-xl shadow-sm border border-slate-200 flex items-center">
            <div class="p-4 rounded-full bg-indigo-50 text-indigo-600 mr-4">
                <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path></svg>
            </div>
            <div>
                <p class="text-sm font-medium text-slate-500">Active Courses</p>
                <p class="text-3xl font-bold text-slate-900">${courseCount}</p>
            </div>
        </div>

        <div class="bg-white p-6 rounded-xl shadow-sm border border-slate-200 flex items-center">
            <div class="p-4 rounded-full bg-emerald-50 text-emerald-600 mr-4">
                <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
            </div>
            <div>
                <p class="text-sm font-medium text-slate-500">Total Enrollments</p>
                <p class="text-3xl font-bold text-slate-900">${enrollmentCount}</p>
            </div>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">

        <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="px-6 py-4 border-b border-slate-100 flex justify-between items-center">
                <h3 class="font-bold text-slate-800">Recently Registered Students</h3>
                <a href="students" class="text-sm text-cyan-600 hover:text-cyan-700 font-medium">View All &rarr;</a>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-sm text-left">
                    <thead class="text-xs text-slate-500 uppercase bg-slate-50 border-b border-slate-100">
                    <tr>
                        <th class="px-6 py-3 font-medium">Name</th>
                        <th class="px-6 py-3 font-medium">Date Joined</th>
                        <th class="px-6 py-3 font-medium">Major</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
                    <c:forEach var="student" items="${recentStudents}">
                        <tr class="hover:bg-slate-50 transition">
                            <td class="px-6 py-4 font-medium text-slate-900">
                                <div class="flex items-center">
                                    <div class="h-8 w-8 rounded-full bg-slate-100 flex items-center justify-center text-xs font-bold text-slate-500 mr-3">
                                            ${student.name.charAt(0)}
                                    </div>
                                        ${student.name}
                                </div>
                            </td>
                            <td class="px-6 py-4 text-slate-500">${student.enrollmentDate}</td>
                            <td class="px-6 py-4 text-slate-500">${student.major}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty recentStudents}">
                        <tr>
                            <td colspan="3" class="px-6 py-8 text-center text-slate-400">No recent activity.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6">
            <h3 class="font-bold text-slate-800 mb-4">Quick Actions</h3>
            <div class="space-y-3">
                <a href="students" class="block w-full text-left px-4 py-3 rounded-lg border border-slate-200 hover:border-cyan-500 hover:text-cyan-600 hover:bg-cyan-50 transition flex items-center group">
                    <div class="bg-slate-100 group-hover:bg-cyan-200 p-2 rounded-md mr-3 transition">
                        <svg class="w-5 h-5 text-slate-500 group-hover:text-cyan-700" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path></svg>
                    </div>
                    <span class="font-medium">Register New Student</span>
                </a>

                <a href="courses" class="block w-full text-left px-4 py-3 rounded-lg border border-slate-200 hover:border-indigo-500 hover:text-indigo-600 hover:bg-indigo-50 transition flex items-center group">
                    <div class="bg-slate-100 group-hover:bg-indigo-200 p-2 rounded-md mr-3 transition">
                        <svg class="w-5 h-5 text-slate-500 group-hover:text-indigo-700" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
                    </div>
                    <span class="font-medium">Create New Course</span>
                </a>

                <button disabled class="block w-full text-left px-4 py-3 rounded-lg border border-slate-100 text-slate-400 cursor-not-allowed flex items-center">
                    <div class="bg-slate-50 p-2 rounded-md mr-3">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
                    </div>
                    <span class="font-medium">Generate Reports (Coming Soon)</span>
                </button>
            </div>
        </div>

    </div>

</main>

</body>
</html>