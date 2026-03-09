@extends('adminlte::page')

@section('title', 'Modifier un règlement client')

@section('content')
<div class="container">
    <h1>Modifier le règlement client</h1>
    <form action="{{ route('paiements.update', $reglement->id) }}" method="POST">
        @csrf
        @method('PUT')

        <div class="mb-3">
            <label for="client_id" class="form-label">Client</label>
            <select name="client_id" id="client_id" class="form-control" required>
                <option value="">Sélectionner un client</option>
                @foreach($clients as $client)
                    <option value="{{ $client->id }}" {{ $reglement->client_id == $client->id ? 'selected' : '' }}>
                        {{ $client->name }}
                    </option>
                @endforeach
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Factures</label>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="check_all"></th>
                        <th>ID</th>
                        <th>Référence</th>
                        <th>Reste à payer</th>
                        <th>Montant à payer</th>
                    </tr>
                </thead>
                 <tbody id="bons_table_body">
               
            </table>
        </div>

        <div class="mb-3">
            <label>Total règlement</label>
            <input type="number" step="0.01" name="montant" id="montant_total" class="form-control" readonly value="{{ $reglement->montant }}">
        </div>

        <div class="mb-3">
            <label for="date_reglement">Date</label>
            <input type="date" name="date_reglement" value="{{ $reglement->date_reglement }}" class="form-control" required>
        </div>

        <div class="mb-3">
            <label for="mode_paiement">Mode de paiement</label>
            <select name="mode_paiement" class="form-control" required>
                <option value="">Sélectionner</option>
                <option value="Espèces" {{ $reglement->mode_paiement=='Espèces'?'selected':'' }}>Espèces</option>
                <option value="Chèque" {{ $reglement->mode_paiement=='Chèque'?'selected':'' }}>Chèque</option>
                <option value="Virement bancaire" {{ $reglement->mode_paiement=='Virement bancaire'?'selected':'' }}>Virement bancaire</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="reference">Référence</label>
            <input type="text" name="reference" value="{{ $reglement->reference }}" class="form-control">
        </div>

        <div class="mb-3">
            <label for="notes">Obs</label>
            <textarea name="notes" class="form-control">{{ $reglement->notes }}</textarea>
        </div>

        <button type="submit" class="btn btn-primary">Mettre à jour</button>
    </form>
</div>

<script>
let clientId = {{ $reglement->client_id }};

let selectedBons = @json(
    $reglement->factures->mapWithKeys(fn($a)=>[
        $a->id => $a->pivot->mont_paye
    ])
);

document.addEventListener('DOMContentLoaded', function(){

   fetch('/client/' + clientId + '/factures-edit/{{ $reglement->id }}')
    .then(res => res.json())
    .then(data => {

        let tbody = document.getElementById('bons_table_body');

        data.forEach(function(bon){

          ////  let isChecked = selectedBons[bon.id] !== undefined;
            let isChecked = bon.montant_deja_paye > 0;
            let montantValue = bon.montant_deja_paye;

            let row = `
            <tr>
                <td>
                    <input type="checkbox"
                        class="bon-check"
                        ${isChecked ? 'checked':''}>
                </td>
                <td>${bon.id}</td>
                <td>${bon.numero_facture ?? 'Sans référence'}</td>
                <td>${bon.reste_a_payer} DH</td>
                <td>
                    <input type="number"
                        name="montants[${bon.id}]"
                        step="0.01"
                       max="${bon.reste_a_payer}"
                       data-max="${bon.reste_a_payer}"
                        class="form-control montant-input"
                        value="${montantValue}"
                        ${isChecked ? '' : 'disabled'}>
                </td>
            </tr>`;

            tbody.insertAdjacentHTML('beforeend', row);
        });

        calculateTotal();
    });
});

/* Même JS que create */
document.addEventListener('change', function(e){

    if(e.target.classList.contains('bon-check')){
        let input = e.target.closest('tr').querySelector('.montant-input');

        if(e.target.checked){
            input.disabled = false;
            if(!input.value) input.value = input.dataset.max;
        } else {
            input.disabled = true;
            input.value = '';
        }
        calculateTotal();
    }

    if(e.target.classList.contains('montant-input')){
        let max = parseFloat(e.target.dataset.max);
        let value = parseFloat(e.target.value);

        if(value > max) e.target.value = max;
        if(value < 0 || isNaN(value)) e.target.value = 0;

        calculateTotal();
    }
});

function calculateTotal(){
    let total = 0;

    document.querySelectorAll('.montant-input').forEach(input=>{
        if(!input.disabled && input.value){
            total += parseFloat(input.value);
        }
    });

    document.getElementById('montant_total').value = total.toFixed(2);
}
</script>
@endsection