<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

return new class extends Migration
{
    public function up(): void
    {
        if (! Schema::hasColumn('entreprises', 'plan')) {
            Schema::table('entreprises', function (Blueprint $table) {
                $table->string('plan', 50)->default('trial');
                $table->string('subscription_status', 50)->default('trialing');
                $table->timestamp('trial_started_at')->nullable();
                $table->timestamp('trial_ends_at')->nullable();
                $table->timestamp('subscription_started_at')->nullable();
                $table->timestamp('subscription_ends_at')->nullable();
            });
        }

        $now = Carbon::now();
        DB::table('entreprises')->whereNull('trial_started_at')->update([
            'plan' => 'trial',
            'subscription_status' => 'trialing',
            'trial_started_at' => $now,
            'trial_ends_at' => $now->copy()->addDays(config('saas.trial_days')),
        ]);
    }

    public function down(): void
    {
        if (Schema::hasColumn('entreprises', 'plan')) {
            Schema::table('entreprises', function (Blueprint $table) {
                $table->dropColumn([
                    'plan',
                    'subscription_status',
                    'trial_started_at',
                    'trial_ends_at',
                    'subscription_started_at',
                    'subscription_ends_at',
                ]);
            });
        }
    }
};
