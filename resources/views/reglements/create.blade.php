@extends('adminlte::page')

@section('content')
<div class="container">
    <h1>Créer un règlement fournisseur</h1>
    <form action="{{ route('reglements.store') }}" method="POST">
        @csrf
        {{-- Client --}}
                        <div class="mb-3">
                            <label for="fournisseur_id" class="form-label">Fournisseur</label>
                            <select name="fournisseur_id" id="fournisseur_id"  class="form-control form-control-sm w-50" required>
                                <option value="">Sélectionner un fournisseur</option>
                                @foreach($fournisseurs as $fournisseur)
                                    <option value="{{ $fournisseur->id }}" {{ old('fournisseur_id') == $fournisseur->id ? 'selected' : '' }}>{{ $fournisseur->name }}</option>
                                @endforeach
                            </select>
                        </div>
                      <div class="mb-3">
    <label class="form-label">Bons non payés</label>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>
                    <input type="checkbox" id="check_all">
                </th>
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
    <input type="number" step="0.01" name="montant" id="montant_total" class="form-control w-50" readonly>
</div>
        <div class="mb-3">
            <label for="date_reglement" class="form-label">Date</label>
            <input type="date" name="date_reglement" class="form-control w-50" required>
        </div>
        <div class="mb-3">
            <label for="mode_paiement" class="form-label">Mode de paiement</label>
             <select name="mode_paiement" id="mode_paiement" class="form-control w-50" required>
                                <option value="">Sélectionner un mode de paiement</option>
                                <option value="Espèces">Espèces</option>
                                <option value="Chèque">Chèque</option>
                                <option value="Virement bancaire">Virement bancaire</option>
                            </select>
           
        </div>
        <div class="mb-3">
            <label for="reference" class="form-label">Référence</label>
            <input type="text" name="reference" class="form-control">
        </div>
        <div class="mb-3">
            <label for="notes" class="form-label">Obs</label>
            <textarea name="notes" class="form-control"></textarea>
        </div>
        
        <button type="submit" class="btn btn-primary">Créer</button>
    </form>
</div>
<script>
document.getElementById('fournisseur_id').addEventListener('change', function () {

    let fournisseurId = this.value;
    let tbody = document.getElementById('bons_table_body');
    tbody.innerHTML = '';
    document.getElementById('montant_total').value = 0;

    if (fournisseurId) {
        fetch('/fournisseur/' + fournisseurId + '/bons-non-payes')
        .then(response => response.json())
        .then(data => {

            data.forEach(function(bon) {

                let row = `
                    <tr>
                        <td>
                            <input type="checkbox" class="bon-check">
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
                                data-id="${bon.id}"
                                class="form-control montant-input"
                                disabled>
                        </td>
                    </tr>
                `;

                tbody.insertAdjacentHTML('beforeend', row);
            });
        });
    }
});


/* Activer input quand checkbox cochée */
document.addEventListener('change', function(e){

    if(e.target.classList.contains('bon-check')){
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
    let value = parseFloat(e.target.value);

    if(value > max){
        e.target.value = max;
    }

    if(value < 0 || isNaN(value)){
        e.target.value = 0;
    }

    calculateTotal();
}

});


/* Tout sélectionner */
document.getElementById('check_all').addEventListener('change', function(){

    document.querySelectorAll('.bon-check').forEach(cb => {
        cb.checked = this.checked;
        cb.dispatchEvent(new Event('change'));
    });

});


function calculateTotal(){

    let total = 0;

    document.querySelectorAll('.montant-input').forEach(input => {

        if(!input.disabled && input.value){
            total += parseFloat(input.value);
        }

    });

    document.getElementById('montant_total').value = total.toFixed(2);
}
</script>
@endsection
