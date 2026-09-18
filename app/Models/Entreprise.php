<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Entreprise extends Model
{
protected $fillable = [
    'name',
    'adresse',
    'tel',
    'email',
    'ice',
    'logo',
    'document_background',
    'document_logo_position',
    'document_primary_color',
    'document_secondary_color',
        'plan',
        'subscription_status',
        'trial_started_at',
        'trial_ends_at',
        'subscription_started_at',
        'subscription_ends_at',
];

    protected $casts = [
        'trial_started_at' => 'datetime',
        'trial_ends_at' => 'datetime',
        'subscription_started_at' => 'datetime',
        'subscription_ends_at' => 'datetime',
    ];

  public function users(): HasMany
    {
        return $this->hasMany(User::class);
    }

      public function hasActiveTrial(): bool
      {
          return $this->plan === 'trial'
              && $this->subscription_status === 'trialing'
              && $this->trial_ends_at?->isFuture();
      }

      public function isSubscriptionActive(): bool
      {
          return $this->plan === 'premium'
              && $this->subscription_status === 'active'
              && (! $this->subscription_ends_at || $this->subscription_ends_at->isFuture());
      }

      public function isAccessAllowed(): bool
      {
          return $this->hasActiveTrial() || $this->isSubscriptionActive();
      }

      public function getDaysRemainingInTrial(): int
      {
          if (! $this->hasActiveTrial()) {
              return 0;
          }

          return Carbon::now()->diffInDays($this->trial_ends_at, false);
      }

}

