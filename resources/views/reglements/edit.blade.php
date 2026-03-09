@extends('adminlte::page')

@section('content')
<div class="container">
    <h1>Modifier règlement fournisseur</h1>

    <form action="{{ route('reglements.update',$reglement->id) }}" method="POST">
        @csrf
        @method('PUT')

        {{-- Fournisseur (bloqué) --}}
        <div class="mb-1">
            <label class="form-label">Fournisseur</label>
            <select class="form-control w-50" disabled>
                @foreach($fournisseurs as $fournisseur)
                    <option value="{{ $fournisseur->id }}"
                        {{ $reglement->fournisseur_id == $fournisseur->id ? 'selected' : '' }}>
                        {{ $fournisseur->name }}
                    </option>
                @endforeach
            </select>
        </div>

        {{-- Bons --}}
        <div class="mb-3">
            <label class="form-label">Bons</label>

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
                </tbody>
            </table>
        </div>

        <div class="mb-3">
            <label>Total règlement</label>
            <input type="number"
                   step="0.01"
                   name="montant"
                   id="montant_total"
                   class="form-control w-50"
                   value="{{ $reglement->montant }}"
                   readonly>
        </div>

        <div class="mb-3">
            <label>Date</label>
            <input type="date"
                   name="date_reglement"
                   class="form-control w-50"
                   value="{{ $reglement->date_reglement }}">
        </div>

        <div class="mb-3">
            <label>Mode de paiement</label>
            <select name="mode_paiement" class="form-control w-50">
                <option value="Espèces" {{ $reglement->mode_paiement=='Espèces'?'selected':'' }}>Espèces</option>
                <option value="Chèque" {{ $reglement->mode_paiement=='Chèque'?'selected':'' }}>Chèque</option>
                <option value="Virement bancaire" {{ $reglement->mode_paiement=='Virement bancaire'?'selected':'' }}>Virement bancaire</option>
            </select>
        </div>

        <div class="mb-3">
            <label>Référence</label>
            <input type="text"
                   name="reference"
                   class="form-control"
                   value="{{ $reglement->reference }}">
        </div>

        <div class="mb-3">
            <label>Obs</label>
            <textarea name="notes" class="form-control">{{ $reglement->notes }}</textarea>
        </div>

        <button class="btn btn-primary">Mettre à jour</button>
    </form>
</div>

<script>
let fournisseurId = {{ $reglement->fournisseur_id }};
let selectedBons = @json(
    $reglement->achats->mapWithKeys(fn($a)=>[
        $a->id => $a->pivot->mont_paye
    ])
);

document.addEventListener('DOMContentLoaded', function(){

   fetch('/fournisseur/' + fournisseurId + '/bons-edit/{{ $reglement->id }}')
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
                <td>${bon.numero_achat ?? 'Sans référence'}</td>
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