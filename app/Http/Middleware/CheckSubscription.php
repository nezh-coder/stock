<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class CheckSubscription
{
    public function handle(Request $request, Closure $next): Response
    {
        $entreprise = $request->user()?->entreprise;

        $allowedRoutes = [
            'dashboard', 'profile.*', 'subscription.*', 'enterprise.settings.*',
        ];
        $isAllowedRoute = collect($allowedRoutes)->contains(fn ($pattern) => $request->routeIs($pattern));

        if (! $entreprise || $entreprise->isAccessAllowed() || $isAllowedRoute) {
            return $next($request);
        }

        if ($request->expectsJson()) {
            return response()->json(['message' => 'Votre période d’essai gratuit est terminée.'], 402);
        }

        return redirect()->route('subscription.show')
            ->with('error', 'Votre période d’essai gratuit est terminée.');
    }
}
