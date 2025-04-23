from pathlib import Path

import torch
import lightning.pytorch as pl
from torch.utils.data import DataLoader

# HuggingFace Datasets
from datasets import load_dataset


class ImageDataModule(pl.LightningDataModule):

  def __init__(
      self,
      data_dir: str = "data",
      image_size: int = 224,
      batch_size: int = 32,
      num_workers: int = 4,
  ):
    super().__init__()
    self.data_dir = Path(data_dir)
    self.dataset = load_dataset(data_dir)
