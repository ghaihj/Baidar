<?php

namespace App\Filament\Resources\PlantRegionProfiles\Pages;

use App\Filament\Resources\PlantRegionProfiles\PlantRegionProfileResource;
use Filament\Actions\DeleteAction;
use Filament\Resources\Pages\EditRecord;

class EditPlantRegionProfile extends EditRecord
{
    protected static string $resource = PlantRegionProfileResource::class;

    protected function getHeaderActions(): array
    {
        return [
            DeleteAction::make(),
        ];
    }
}
