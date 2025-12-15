<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Portal | Horizon Tech</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-slate-50 min-h-screen text-slate-900 font-sans">

<nav class="bg-white border-b border-slate-200 sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <div class="flex items-center">
                <span class="text-xl font-bold text-cyan-600 tracking-tight">Horizon Portal</span>
            </div>
            <div class="flex items-center gap-4">
                <span class="text-sm text-slate-500 hidden md:block">Welcome, ${student.name}</span>
                <a href="LogoutServlet" class="text-slate-700 border border-slate-300 bg-white hover:bg-slate-100 focus:ring-4 focus:ring-slate-200 font-medium rounded-md text-sm px-4 py-2 transition duration-150 ease-in-out">
                    <svg class="w-4 h-4 inline mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3v-4a3 3 0 013-3h3m2-3V4a3 3 0 013-3h4a3 3 0 013 3v4"></path></svg>
                    Logout
                </a>
            </div>
        </div>
    </div>
</nav>

<main class="container mx-auto max-w-7xl px-4 py-10">

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">

        <div class="lg:col-span-1">
            <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden sticky top-24">
                <div class="h-24 bg-gradient-to-r from-slate-800 to-slate-900"></div>

                <div class="px-6 pb-6 relative">
                    <div class="-mt-12 mb-4 flex justify-center">
                        <div class="h-24 w-24 rounded-full bg-cyan-100 flex items-center justify-center text-cyan-700 font-bold text-3xl border-4 border-white shadow-sm">
                            ${student.name.charAt(0)}
                        </div>
                    </div>

                    <div class="text-center mb-6">
                        <h2 class="text-xl font-bold text-slate-900">${student.name}</h2>
                        <p class="text-sm text-slate-500">${student.major}</p>
                    </div>

                    <div class="border-t border-slate-100 my-4"></div>

                    <div class="space-y-4">
                        <div class="flex justify-between items-center">
                            <span class="text-sm text-slate-500">Student ID</span>
                            <span class="text-sm font-medium text-slate-900">#${student.id}</span>
                        </div>

                        <div class="flex justify-between items-center">
                            <span class="text-sm text-slate-500">Email</span>
                            <span class="text-sm font-medium text-slate-900 truncate max-w-[150px]" title="${student.email}">${student.email}</span>
                        </div>

                        <div class="flex justify-between items-center">
                            <span class="text-sm text-slate-500">Enrolled Since</span>
                            <span class="text-sm font-medium text-slate-900">${student.enrollmentDate}</span>
                        </div>

                        <div class="flex justify-between items-center">
                            <span class="text-sm text-slate-500">GPA</span>
                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-sm font-bold ${student.gpa >= 3.0 ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}">
                                ${student.gpa}
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="lg:col-span-2">
            <div class="flex items-center justify-between mb-6">
                <div>
                    <h2 class="text-2xl font-bold text-slate-900 tracking-tight">Academic Record</h2>
                    <p class="text-slate-500 text-sm">Your enrolled courses and grades.</p>
                </div>
                <span class="bg-cyan-50 text-cyan-700 text-xs font-bold px-3 py-1 rounded-full">
                        ${enrollments.size()} Courses
                    </span>
            </div>

            <c:choose>
                <c:when test="${not empty enrollments}">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                        <c:forEach var="enrollment" items="${enrollments}">
                            <div class="bg-white rounded-lg border border-slate-200 shadow-sm hover:shadow-md transition-shadow duration-200 overflow-hidden flex flex-col h-full">
                                <div class="p-5 flex-grow">
                                    <div class="flex justify-between items-start mb-3">
                                        <h3 class="text-base font-bold text-slate-900 leading-snug">
                                                ${enrollment.courseName}
                                        </h3>

                                        <c:choose>
                                            <c:when test="${not empty enrollment.grade}">
                                                    <span class="flex-shrink-0 ml-2 inline-flex items-center justify-center h-8 w-8 rounded-full bg-slate-50 text-slate-700 font-bold text-sm border border-slate-200">
                                                            ${enrollment.grade}
                                                    </span>
                                            </c:when>
                                            <c:otherwise>
                                                    <span class="flex-shrink-0 ml-2 text-[10px] uppercase font-bold text-slate-400 bg-slate-50 px-2 py-1 rounded border border-slate-100">
                                                        Ongoing
                                                    </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="flex items-center text-xs text-slate-400 mt-auto pt-2 border-t border-slate-50">
                                        <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                                        Enrolled: ${enrollment.enrollmentDate}
                                    </div>
                                </div>
                                <div class="h-1 w-full ${enrollment.grade == 'A' ? 'bg-cyan-500' : (enrollment.grade == 'B' ? 'bg-blue-500' : 'bg-slate-200')}"></div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="bg-white rounded-xl border border-dashed border-slate-300 p-10 text-center">
                        <div class="mx-auto h-12 w-12 text-slate-300 mb-3">
                            <svg fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path></svg>
                        </div>
                        <h3 class="text-sm font-medium text-slate-900">No courses enrolled</h3>
                        <p class="mt-1 text-sm text-slate-500">It looks like you haven't started any classes yet.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

</main>

</body>
</html>