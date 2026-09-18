@extends('adminlte::page')

@section('title', 'Abonnement')

@section('content')
<div class="container-fluid py-3">
    @if(session('error'))<div class="alert alert-warning">{{ session('error') }}</div>@endif
    <div class="card card-primary card-outline">
        <div class="card-header"><h3 class="card-title"><i class="fas fa-crown mr-2"></i>Votre forfait actuel : {{ $planName }}</h3></div>
        <div class="card-body">
            @if($entreprise->hasActiveTrial())
                <p class="lead">Essai gratuit · <strong>{{ $entreprise->getDaysRemainingInTrial() }} jours restants</strong></p>
                <p>Du {{ $entreprise->trial_started_at?->format('d/m/Y') }} au {{ $entreprise->trial_ends_at?->format('d/m/Y') }}</p>
            @else
                <div class="alert alert-warning"><strong>Votre période d'essai gratuit est terminée.</strong><br>Vos données sont conservées. Une formule payante pourra être activée ultérieurement.</div>
            @endif
            <div class="row mt-4">
                @foreach($usage as $item)
                    <div class="col-md-6 col-lg-4 mb-3"><div class="border rounded p-3"><div class="d-flex justify-content-between"><span>{{ ucfirst(str_replace('_', ' ', $item['resource'])) }}</span><strong>{{ $item['used'] }} / {{ $item['limit'] ?? 'Illimité' }}</strong></div>@if($item['limit'])<div class="progress mt-2"><div class="progress-bar {{ $item['used'] >= $item['limit'] ? 'bg-danger' : 'bg-primary' }}" style="width: {{ min(100, ($item['used'] / max(1, $item['limit'])) * 100) }}%"></div></div>@endif</div></div>
                @endforeach
            </div>
            <button class="btn btn-primary" type="button" disabled><i class="fas fa-arrow-up mr-1"></i>Choisir une formule</button>
            <a class="btn btn-outline-secondary ml-2" href="mailto:{{ $entreprise->email ?: config('mail.from.address') }}">Contacter le support</a>
        </div>
    </div>
</div>
@endsection
