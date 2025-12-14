<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 min-h-screen">

<jsp:include page="/navbar.jsp" />

<main class="container mx-auto max-w-7xl px-4 py-10">
    <header class="mb-8">
        <h1 class="text-3xl font-bold text-slate-900 tracking-tight">System Overview</h1>
        <p class="text-slate-500">A quick look at the vital statistics of the Student Information System.</p>
    </header>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">

        <div class="bg-white p-5 rounded-lg shadow-sm border border-slate-200">
            <div class="flex items-center justify-between">
                <h3 class="text-sm font-medium text-slate-500">Total Students</h3>
                <svg class="w-5 h-5 text-cyan-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20h-2m2-2v-2a3 3 0 00-5.356-1.857M12 18v-2a3 3 0 00-5.356-1.857M6 20H1v-2a3 3 0 016-1m-1 0v-2a3 3 0 014-3.326v-1.154a3 3 0 00-1-2.236V4a3 3 0 00-3-3h-2a3 3 0 00-3 3v2.284a3 3 0 00-1 2.236v1.154a3 3 0 004 3.326z"></path></svg>
            </div>
            <p class="text-3xl font-bold text-slate-900 mt-1">1,500</p>
            <p class="text-xs text-slate-400 mt-1">+12% from last month</p>
        </div>

        <div class="bg-white p-5 rounded-lg shadow-sm border border-slate-200">
            <div class="flex items-center justify-between">
                <h3 class="text-sm font-medium text-slate-500">Active Courses</h3>
                <svg class="w-5 h-5 text-cyan-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.409 9.333 5 8 5a2 2 0 00-2 2v2M12 6.253C13.168 5.409 14.667 5 16 5a2 2 0 012 2v2M12 6.253h8M12 19h8M7 9v12m0 0a2 2 0 002 2h2a2 2 0 002-2v-2a2 2 0 00-2-2H9a2 2 0 00-2 2v2a2 2 0 002 2h2M12 6v14"></path></svg>
            </div>
            <p class="text-3xl font-bold text-slate-900 mt-1">55</p>
            <p class="text-xs text-slate-400 mt-1">No change this semester</p>
        </div>

        <div class="bg-white p-5 rounded-lg shadow-sm border border-slate-200">
            <div class="flex items-center justify-between">
                <h3 class="text-sm font-medium text-slate-500">New Enrollments</h3>
                <svg class="w-5 h-5 text-cyan-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 13h6m-3-3v6m5 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
            </div>
            <p class="text-3xl font-bold text-slate-900 mt-1">12</p>
            <p class="text-xs text-slate-400 mt-1">Requires approval</p>
        </div>

        <div class="bg-white p-5 rounded-lg shadow-sm border border-slate-200">
            <div class="flex items-center justify-between">
                <h3 class="text-sm font-medium text-slate-500">System Health</h3>
                <svg class="w-5 h-5 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
            </div>
            <p class="text-3xl font-bold text-slate-900 mt-1">Stable</p>
            <p class="text-xs text-slate-400 mt-1">All services operational</p>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div class="lg:col-span-2 bg-white p-6 rounded-lg shadow-sm border border-slate-200">
            <h2 class="text-xl font-semibold text-slate-900 mb-4">Recent Student Activity</h2>
            <ul class="divide-y divide-slate-100">
                <li class="py-3 flex justify-between items-center">
                    <span class="text-slate-700 font-medium">S00123 submitted **Assignment 3**.</span>
                    <span class="text-xs text-slate-400">2 minutes ago</span>
                </li>
                <li class="py-3 flex justify-between items-center">
                    <span class="text-slate-700 font-medium">S00456 enrolled in **Physics 101**.</span>
                    <span class="text-xs text-slate-400">1 hour ago</span>
                </li>
                <li class="py-3 flex justify-between items-center">
                    <span class="text-slate-700 font-medium">S00789 viewed profile.</span>
                    <span class="text-xs text-slate-400">4 hours ago</span>
                </li>
                <li class="py-3 flex justify-between items-center">
                    <span class="text-slate-700 font-medium">S00101 completed **Course Feedback**.</span>
                    <span class="text-xs text-slate-400">1 day ago</span>
                </li>
            </ul>
        </div>

        <div class="bg-white p-6 rounded-lg shadow-sm border border-slate-200 flex flex-col justify-between">
            <div>
                <h2 class="text-xl font-semibold text-slate-900 mb-4">Quick Actions</h2>
                <p class="text-sm text-slate-500 mb-6">Manage key administrative tasks instantly.</p>
            </div>
            <div class="space-y-3">
                <button class="w-full bg-cyan-600 text-white py-2 rounded-md hover:bg-cyan-700 transition duration-150">
                    Approve Enrollments (12)
                </button>
                <button class="w-full bg-slate-100 text-slate-700 border border-slate-300 py-2 rounded-md hover:bg-slate-200 transition duration-150">
                    View System Logs
                </button>
                <button class="w-full bg-slate-100 text-slate-700 border border-slate-300 py-2 rounded-md hover:bg-slate-200 transition duration-150">
                    Backup Database
                </button>
            </div>
        </div>
    </div>

</main>

</body>
</html>