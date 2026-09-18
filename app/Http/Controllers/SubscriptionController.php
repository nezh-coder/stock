<?php

namespace App\Http\Controllers;

use App\Services\SaasLimitService;
use Illuminate\View\View;

class SubscriptionController extends Controller
{
    public function show(SaasLimitService $limits): View
    {
        $entreprise = auth()->user()->entreprise;

        return view('subscription.show', [
            'entreprise' => $entreprise,
            'usage' => $limits->usage(),
            'planName' => config('saas.plans.'.($entreprise->plan ?: 'trial').'.name'),
        ]);
    }
}
