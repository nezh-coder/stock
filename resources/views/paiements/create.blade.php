@extends('adminlte::page')

@section('title', 'Créer un règlement client')

@section('content')
<div class="container">
    <h1>Créer un règlement client</h1>
    <form action="{{ route('paiements.store') }}" method="POST">
        @csrf

        {{-- Client --}}
        <div class="mb-3 w-50">
            <label for="client_id" class="form-label">Client</label>
            <select name="client_id" id="client_id" class="form-control" required>
                <option value="">Sélectionner un client</option>
                @foreach($clients as $client)
                    <option value="{{ $client->id }}">{{ $client->name }}</option>
                @endforeach
            </select>
        </div>

        {{-- Factures non payées --}}
        <div class="mb-3">
            <label class="form-label">Factures non payées</label>
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
                <tbody id="factures_table_body">
                    {{-- Factures dynamiques via JS --}}
                </tbody>
            </table>
        </div>

       {{-- Total --}}
<div class="row mb-3">

    <div class="col-md-6">
        <label>Total règlement</label>
        <input type="number" step="0.01" 
               name="montant" 
               id="montant_total" 
               class="form-control" 
               readonly>
    </div>

    <div class="col-md-6">
        <label for="date_reglement">Date</label>
        <input type="date" 
               name="date_reglement" 
               class="form-control" 
               required>
    </div>

</div>
     <div class="row mb-3">
    <div class="col-md-6">
            <label for="mode_paiement">Mode de paiement</label>
            <select name="mode_paiement" class="form-control" required>
                <option value="">Sélectionner</option>
                <option value="Espèces">Espèces</option>
                <option value="Chèque">Chèque</option>
                <option value="Virement bancaire">Virement bancaire</option>
            </select>
        </div>

        <div class="col-md-6">
            <label for="reference">Référence</label>
            <input type="text" name="reference" class="form-control">
        </div>
 </div>
        <div class="mb-3 ">
            <label for="notes">Obs</label>
            <textarea name="notes" class="form-control"></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Créer</button>
    </form>
</div>

{{-- JS dynamique --}}
<script>
document.getElementById('client_id').addEventListener('change', function(){
    let clientId = this.value;
    let tbody = document.getElementById('factures_table_body');
    tbody.innerHTML = '';
    document.getElementById('montant_total').value = 0;

    if(clientId){ 
        fetch('/client/' + clientId + '/factures-non-payees')
        .then(res => res.json())
        .then(data => {
            data.forEach(facture => {
                let row = `
                    <tr>
                        <td><input type="checkbox" class="facture-check"></td>
                        <td>${facture.id}</td>
                        <td>${facture.numero_facture ?? 'Sans référence'}</td>
                        <td>${facture.reste_a_payer.toFixed(2)} DH</td>
                        <td>
                            <input type="number"
                                name="montants[${facture.id}]"
                                class="form-control montant-input"
                                step="0.01"
                                data-max="${facture.reste_a_payer}"
                                disabled>
                        </td>
                    </tr>
                `;
                tbody.insertAdjacentHTML('beforeend', row);
            });
        });
    }
});

// Activer input quand checkbox cochée
document.addEventListener('change', function(e){
    if(e.target.classList.contains('facture-check')){
        let input = e.target.closest('tr').querySelector('.montant-input');
        if(e.target.checked){
            input.disabled = false;
            input.value = input.dataset.max;
        } else {
            input.disabled = true;
            input.value = '';
        }
        calculateTotal();
    }

    if(e.target.classList.contains('montant-input')){
        let max = parseFloat(e.target.dataset.max);
        if(parseFloat(e.target.value) > max) e.target.value = max;
        if(e.target.value < 0 || isNaN(e.target.value)) e.target.value = 0;
        calculateTotal();
    }
});

// Tout sélectionner
document.getElementById('check_all').addEventListener('change', function(){
    document.querySelectorAll('.facture-check').forEach(cb => {
        cb.checked = this.checked;
        cb.dispatchEvent(new Event('change'));
    });
});

// Calcul total
function calculateTotal(){
    let total = 0;
    document.querySelectorAll('.montant-input').forEach(input => {
        if(!input.disabled && input.value) total += parseFloat(input.value);
    });
    document.getElementById('montant_total').value = total.toFixed(2);
}
</script>
@endsection